#!/usr/bin/env bash

# wtf.

if [[ -z $HV_LOADED ]]; then
  . "${dir_bashlib}/500kv.bash"
fi

# -----------------------------------------------------------------------------
# wheretf: Finds the source of a shell function.
# -----------------------------------------------------------------------------

wheretf()
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

} # /wheretf()

# -----------------------------------------------------------------------------
# wtf: Explains what a thing is.
# -----------------------------------------------------------------------------

wtf()
{
  # This function uses extended globbing patterns like `@(foo|bar)`, and so
  # requires the shell option `extglob` to be enabled.
  shopt -q extglob || shopt -s extglob

  # By default, `wtf` displays only the first result.
  # Use `wtf -a` to display all results.
  if [[ $1 == -a ]]; then
    shift
  else
    local one_and_done="true"
  fi

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
            # tilde-ify path for display
            output="${1/#$HOME/$'~'}: $magic"

            hv_chevron     brightgreen,brightblack "${1/#$HOME/$'~'}"
            hv_chevron -tn black,green "$magic"

          else
            hv_err "error" "$magic"
            return # w/ the status `hv_err` passed through from `file`
          fi

          continue # redundant, since we only end up here if ${#types[@]} = 1
        fi

        # Get a list of places $1 can be found.
        local -a places
        places=( $(type -ap "$1") )

        local place; for place in "${places[@]}"; do
          output+="${output:+\\n}${1} is ${place/#$HOME/$'~'}"

          hv_chevron     brightyellow,brightblack "$1"
          hv_chevron -tn black,yellow "${place/#$HOME/$'~'}"

          if [[ -n $one_and_done ]]; then
            break
          fi
        done
        ;;

      alias)
        output="$1 is aliased to ‘${BASH_ALIASES[$1]}’"

        hv_chevron     brightcyan,brightblack "$1"
        hv_chevron -t  black,cyan "$type"
        hv_chevron -tn black,brightcyan "${BASH_ALIASES[$1]}"
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

        output="$name ($type): $desc"

        hv_chevron     brightmagenta,brightblack "$name"
        hv_chevron -t  black,magenta "$type"
        hv_chevron -tn black,brightmagenta "$desc"
        ;;

      function)
        output="$1 is a function"
        hv_chevron    brightblue,brightblack "$1"
        hv_chevron -t black,blue "function"

        if desc=$(wheretf $1); then
          output+=" ($desc)"
          hv_chevron -tn black,brightblue "$desc"
        else
          echo # newline
        fi
        ;;
    esac

    if [[ -n $HV_DISABLE_PP ]]; then
      # Print plain-text output if `hv_chevron` has been suppressed.
      printf "%b" "$output"
      echo # newline
    fi

    if [[ -n $one_and_done ]]; then
      break
    fi
  done

  return 0
} # /wtf()

unalias where what which 2>/dev/null
unset -f where what which

where() { wheretf "$@"; }
what() { wtf "$@"; }
which() { builtin type "$@"; }

