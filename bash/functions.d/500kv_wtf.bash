#!/usr/bin/env bash

# wtf.

if [[ -z $HV_LOADED ]]; then
  . ~/lib/bash/500kv.bash
fi

# -----------------------------------------------------------------------------
# _wtf_func: Finds the source of a shell function.
# -----------------------------------------------------------------------------

_wtf_func()
( # ← We need to enable advanced debugging behaviour to get function info
  #   using only builtins, but it's not for everyday use, so this function is
  #   executed in a (subshell) instead of as a { group }.
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
  ### ZGM TODO: Document and handle more edge cases.

  # Tilde-ify path for display.
  printf "%s:%d\n" "${source_file/#$HOME/$'~'}" "${line_number}"
)

# -----------------------------------------------------------------------------
# _wtf_is: Return a short description of a command.
# -----------------------------------------------------------------------------

_wtf_is()
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
# _wtf_file: Describes a file.
# -----------------------------------------------------------------------------

_wtf_file()
{
  # Tilde-ify path for display
  local desc="${1/#$HOME/$'~'}"
  output="$desc"

  # `file -b` returns "brief" output (no leading filename), `-p` avoids 
  # updating the file's access time if possible, and `h` doesn't follow
  # symlinks (we'll do that later if needed).
  local magic=$(command file -bhp "$1")

  if [[ $magic =~ (broken )?symbolic\ link\ to\ (.+) ]]; then
    local target="${BASH_REMATCH[2]}"
    output+=" -> $target"
    if [[ ${BASH_REMATCH[1]} == broken* ]]; then
      magic="broken link"
    else
      magic=$(command file -bhL "$1")
    fi
    output+=" ($magic)"
  else # not a symlink
    # Truncate output for display
    output+=": ${magic%%:*}"
  fi

  if [[ $magic == broken* ]]; then
    hv_arrow     -f brred -b brblack "$desc"
    hv_arrow -t  -f black -b red "$target"
    hv_arrow -tn -f brred -b brblack "$magic"
  else
    hv_arrow     -f brgreen -b brblack "$desc"
    hv_arrow -tn -f black -b green "$magic"
  fi
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

  # By default, `wtf` displays extra information.
  local extra_output="true"

  # Use `wtf -a` to display all results.
  # Use `wtf -f` to skip shell function lookup.
  # Use `wtf -s` to display less information.
  # Use `wtf -x` to suppress fancy output.
  local OPT OPTIND OPTARG
  while getopts ':afsx' OPT; do
    case $OPT in
      a)  unset -v one_and_done ;;
      f)  local skip_func="true" ;;
      s)  unset -v extra_output ;;
      x)  local HV_DISABLE_PP="true" ;; 
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
    if [[ -e $1 || -L $1 ]]; then
      types=(file)
    else
      hv_err "$1" "not a thing"
      return 1
    fi
  fi

  for type in "${types[@]}"; do
    local output=""
    local desc=""

    case $type in
      file)
        # Are we querying a file directly? If so, it will have a slash in the
        # path (`type` will also return "/path/to/foo is /path/to/foo").
        if [[ $1 =~ / ]]; then
          _wtf_file "$1"
        else
          # Get a list of places $1 can be found.
          local -a places
          places=( $(type -ap "$1") )

          local place; for place in "${places[@]}"; do
            place=${place/#$HOME/$'~'}
            output+="${output:+\\n}${1} is ${place}"

            hv_arrow    -f bryellow -b brblack "$1"
            hv_arrow -t -f black -b yellow "${place}"
            
            if [[ -n $extra_output ]]; then
              desc=$(_wtf_is "$1")
            fi

            if [[ -n $desc ]]; then
              hv_arrow -tn -f black -b bryellow "${desc}"
              # Don't display a description for any additional items.
              unset -v extra_output desc
            elif [[ -z $HV_DISABLE_PP ]]; then
              printf "\n"
            fi

            if [[ -n $one_and_done ]]; then
              break
            fi
          done
        fi
        ;;

      alias)
        local def=${BASH_ALIASES[$1]}
        output="$1 is aliased to ‘${def}’"

        hv_arrow     -f brcyan -b brblack "$1"
        hv_arrow -t  -f black -b cyan "$type"
        hv_arrow -tn -f black -b brcyan "${def}"
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

          name="… $1"

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
              name="… $1 …"
              desc="Define a list of items within a compound command."
              ;;
            "do")
              name="… $1 …"
              desc="Define a list of commands to be executed."
              ;;
            "done")
              name="… $1"
              desc="End a ‘for’, ‘select’, ‘while’, or ‘until’ statement."
              ;;
            "esac")
              name="… $1"
              desc="End a ‘case’ statement."
              ;;
            "then"|"elif"|"else")
              name="… $1 …"
              desc="Execute commands conditionally."
              ;;
            "fi")
              desc="End an ‘if’ statement."
              ;;
          esac
        fi

        output="$name ($type)"

        hv_arrow     -f brmagenta -b brblack "$name"
        hv_arrow -t  -f black -b magenta "$type"

        if [[ -n $extra_output ]]; then
          output+=": $desc"
          hv_arrow -tn -f black -b brmagenta "$desc"
        else
          [[ -z $HV_DISABLE_PP ]] && printf "\n"
        fi
        ;;

      function)
        [[ -n $skip_func ]] && continue
        output="$1 is a function"
        hv_arrow    -f brblue -b brblack "$1"
        hv_arrow -t -f black -b blue "function"

        if desc=$(_wtf_func "$1"); then
          output+=" ($desc)"
          hv_arrow -tn -f black -b brblue "$desc"
        else
          [[ -z $HV_DISABLE_PP ]] && printf "\n"
        fi

        if [[ -n $extra_output ]]; then
          # Also output function source.
          if type -P source-highlight >/dev/null; then
            declare -f "$1" | source-highlight -s bash -f esc
          else
            declare -f "$1"
          fi
        fi
        ;;
    esac

    if [[ -n $HV_DISABLE_PP ]]; then
      # Print plain-text output if `hv_chevron` has been suppressed.
      printf "%b\n" "$output"
    fi

    if [[ -n $one_and_done ]]; then
      break
    fi
  done

  return 0
} # /wtf()
