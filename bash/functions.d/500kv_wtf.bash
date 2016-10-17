#!/usr/bin/env bash

# wtf.

if [[ -z $HV_LOADED ]]; then
  . "${dir_bashlib}/500kv.bash"
fi

# -----------------------------------------------------------------------------
# whencetf: Finds the source of a shell function.
# -----------------------------------------------------------------------------

whencetf()
{
  # We need to enable advanced debugging behaviour to get function information
  # with only builtins, but it's not for everyday use, so automatically
  # disable it when this function is done.
  shopt -q extdebug || trap 'shopt -u extdebug; trap - RETURN;' RETURN
  shopt -s extdebug

  # Require at least one argument. (We will silently ignore $2 and beyond.)
  (( $# > 0 )) || return 64

  # With `extdebug` enabled, `declare -F function_name` prints the function
  # name, line number, and source file. We will capture the latter two
  # in BASH_REMATCH with the following regex:
  local re="^${1}[[:space:]]([[:digit:]]+)[[:space:]](.+)$"

  local location
  if location=$(declare -F "$1") && [[ $location =~ $re ]]; then
    local line_number=${BASH_REMATCH[1]}
    local source_file=${BASH_REMATCH[2]}
  else
    return 1
  fi

  # If the function was declared at the command line, source_file will be
  # "main" (and "the [line number] is not guaranteed to be meaningful").
  # Otherwise, it will be the path to the file where the function was defined.

  # -- TODO: Document and handle more edge cases.

  # Tilde-ify path for display.
  echo "${source_file/#$HOME/$'~'}:${line_number}"

} # /whencetf()

# -----------------------------------------------------------------------------
# wtfis: Return a short description of a command.
# -----------------------------------------------------------------------------

wtfis()
{
  local desc
  local -a results

  if type -P mandb >/dev/null; then
    # Versions of `whatis` distributed with `mandb` support the `-w` switch,
    # which expands globbing characters in the search term, but -- more useful
    # for our purposes -- also returns only exact matches.
    IFS=$'\n' read -ra results -d $'\004' \
    < <(whatis -w "$1" 2>/dev/null)
  else
    # Use `sed` to parse the results from non-mandb `whatis`.
    IFS=$'\n' read -ra results -d $'\004' \
    < <(whatis "$1" 2>/dev/null | sed -nE "/^$1[[:space:](].*/p")
  fi

  (( ${#results[@]} > 0 )) || return

  # Keep only the first result.
  local result=${results[0]}

  # Trim garbage from badly-formed description strings
  local regexp='^(.+) co Copyright \[co\]'
  if [[ $result =~ $regexp ]]; then
    result=${BASH_REMATCH[1]}
  fi

  # Keep only the description by removing everything before the separator.
  desc="${result#* - }"

  printf "$desc"
  [[ -t 1 ]] && printf "\n"
}

# -----------------------------------------------------------------------------
# wtf: Explains what a thing is.
# -----------------------------------------------------------------------------

wtf()
{
  # This function uses extended globbing patterns like `@(foo|bar)`, and so
  # requires the shell option `extglob` to be enabled.
  shopt -q extglob || shopt -s extglob
  
  # By default, `wtf` displays only the first result.
  local one_and_done="true"

  # Use `wtf -a` to display all results.
  # Use `wtf -l` to display additional information.
  local OPT OPTIND OPTARG
  while getopts ':al' OPT; do
    case $OPT in
      a)  unset -v one_and_done ;;
      l)  local extra_output="true" ;;
    '?')  hv_err "-$OPTARG" "invalid option"
          return 1 ;;
    esac
  done
  shift $((OPTIND - 1))

  # Accept only one subject term.
  (( $# == 1 )) || return 64

  # Suppress fancy output from `hv_chevron` if not connected to a terminal.
  if [[ ! -t 1 ]]; then
    local HV_DISABLE_PP="true"
  fi

  # `type -at` displays the type of every available executable named $1 in a
  # short format: "alias", "keyword", "function", "builtin", or "file".
  # Then `uniq` collapses multiple consecutive types, which only ever occurs
  # for files -- all other types are always singular.
  local -a types
  types=( $(type -at "$1" | uniq) )

  if (( ${#types[@]} == 0 )); then
    hv_err "$1" "not a thing"
    return 1
  fi

  for type in "${types[@]}"; do
    local output=""
    local desc=""
    case $type in
      file)
        # Are we querying a file directly? If so, it will have a slash in the
        # path; `type` will also return "/path/to/foo is /path/to/foo".
        if [[ $1 =~ / ]]; then
          # `file -b` returns "brief" output (no leading filename), while `-p`
          # avoids updating the file's access time if possible.
          local magic; if magic=$(file -bp "$1" 2>&1); then
            # Truncate output and tilde-ify path for display
            output="${1/#$HOME/$'~'}: ${magic%%:*}"

            hv_chevron     brightgreen,brightblack "${1/#$HOME/$'~'}"
            hv_chevron -tn black,green "$magic"

          else
            hv_err "error" "$magic"
            return # w/ the status `hv_err` passed through from `file`
          fi

          continue # redundant, since we only end up here if ${#types[@]} = 1
        fi

        if [[ -n $extra_output ]]; then
          local desc=$(wtfis "$1")
        fi

        # Get a list of places $1 can be found.
        local -a places
        places=( $(type -ap "$1") )

        local place; for place in "${places[@]}"; do
          output+="${output:+\\n}${1} is ${place/#$HOME/$'~'}"

          hv_chevron     brightyellow,brightblack "$1"
          hv_chevron -t  black,yellow "${place/#$HOME/$'~'}"
          
          if [[ -n $desc ]]; then
            hv_chevron -tn black,brightyellow "${desc}"
            # Don't display a description for any additional items.
            unset -v extra_output desc
          else
            printf "\n"
          fi

          if [[ -n $one_and_done ]]; then
            break
          fi
        done
        ;;

      alias)
        local def=${BASH_ALIASES[$1]}
        output="$1 is aliased to ‘${def}’"

        hv_chevron     brightcyan,brightblack "$1"
        hv_chevron -t  black,cyan "$type"
        hv_chevron -tn black,brightcyan "${def}"
        ;;

      builtin|keyword)
        local name=$1

        if desc=$(help -d "$1" 2>/dev/null); then
          # Capture "canonical" name.
          name=${desc%% - *}
          # Trim name from beginning of string.
          desc=${desc#* - }

        elif [[ $1 == @(\!|}|]]|in|do|done|esac|then|elif|else|fi) ]]; then
          # This `extglob`-requiring pattern identifies reserved shell words/
          # keywords with no `help -d` entry as of bash-4.4, but which have
          # a "parent" keyword (`for`, `case`, `if`, `while`, etc.)

          name="…$1"

          case $1 in
            "!")
              name=$1
              desc="Invert the return value of a command."
              ;;
            "}")
              name="{ … }"
              desc=$(help -d "{"); desc=${desc#* - }
              ;;
            "]]")
              name="[[ … ]]"
              desc=$(help -d "[["); desc=${desc#* - }
              ;;
            "in")
              name+="…"
              desc="Define a list of items within a compound command."
              ;;
            "do")
              name+="…"
              desc="Define a list of commands to be executed."
              ;;
            "done")
              desc="End a 'for', 'select', 'while', or 'until' statement."
              ;;
            "esac")
              desc="End a 'case' statement."
              ;;
            "then"|"elif"|"else")
              name+="…"
              desc="Execute commands conditionally."
              ;;
            "fi")
              desc="End an 'if' statement."
              ;;
          esac
        fi

        output="$name ($type)"

        hv_chevron     brightmagenta,brightblack "$name"
        hv_chevron -t  black,magenta "$type"

        if [[ -n $extra_output ]]; then
          output+=": $desc"
          hv_chevron -tn black,brightmagenta "$desc"
        else
          [[ -z $HV_DISABLE_PP ]] && printf "\n"
        fi
        ;;

      function)
        output="$1 is a function"
        hv_chevron    brightblue,brightblack "$1"
        hv_chevron -t black,blue "function"

        if desc=$(whencetf "$1"); then
          output+=" ($desc)"
          hv_chevron -tn black,brightblue "$desc"
        else
          [[ -z $HV_DISABLE_PP ]] && printf "\n"
        fi

        if [[ -n $extra_output ]]; then
          # Also output function source.
          if type -P pygmentize >/dev/null; then
            declare -f "$1" | pygmentize -l bash
          else
            declare -f "$1"
          fi
        fi
        ;;
    esac

    if [[ -n $HV_DISABLE_PP ]]; then
      # Print plain-text output if `hv_chevron` has been suppressed.
      printf "%s\n" "$output"
    fi

    if [[ -n $one_and_done ]]; then
      break
    fi
  done

  return 0
} # /wtf()

unalias which 2>/dev/null
which() { builtin type -p "$@"; }
