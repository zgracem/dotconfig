# -----------------------------------------------------------------------------
# ~/.config/bash/_prompt.bash
# -----------------------------------------------------------------------------
# Setup
# -----------------------------------------------------------------------------

# Prompt strings undergo parameter expansion and command substitution
shopt -s promptvars

# Clear prompt-related variables so we can start fresh
unset -v PS{0..4}
unset -v PROMPT_COMMAND
unset -v PROMPT_DIRTRIM

# -----------------------------------------------------------------------------
# Configuration
# -----------------------------------------------------------------------------

# These can be set manually to override the default behaviour.

# If false, skip all the colour setup so the prompt prints plain
: "${Z_PROMPT_COLOUR:=true}"

# If false, display the hostname in the prompt only when connected via SSH.
# If true, always display the hostname in the prompt, even in local sessions.
: "${Z_PROMPT_HOST:=false}"

# If true, set window/tab title to "host@username: pwd"
: "${Z_SET_WINTITLE:=true}"
: "${Z_SET_TABTITLE:=true}"

# Leaving these unquoted so they expand properly.
# shellcheck disable=SC2086
export ${!Z_PROMPT_*} ${!Z_SET_*}

# -----------------------------------------------------------------------------
# Sanity checks for features
# -----------------------------------------------------------------------------

# Only use colours if supported by current terminal
if [[ $TERM_COLOURDEPTH -lt 8 ]]; then
  Z_PROMPT_COLOUR=false
fi

# -----------------------------------------------------------------------------
# Functions
# -----------------------------------------------------------------------------

_z_PS1_compress_pwd()
{ # Usage: _z_PS1_compress_pwd "$PWD"

  # Trims leading elements of the current directory like so:
  #   ~/first/second/3rd/fourth
  #   ~/fir…/sec…/3rd/fourth/fifth
  #   ~/fir…/sec…/3rd/fourth/fifth/sixth
  #   ~/fir…/sec…/3rd/fou…/fifth/sixth/seventh

  # Compress if PWD has >= `$min_depth` elements, not counting a leading `~`.
  local min_depth=5

  # Compress if PWD is >= `$max_length` chars long, overriding `$min_depth`.
  # For shallowly-nested directories with long names.
  local max_length=60

  # Always retain the full names of the last `$keep_dirs` elements.
  local keep_dirs=1

  # When compressing a directory name, keep the first `$keep_chars` characters.
  local keep_chars=3

  # Append `$indicator` to each compressed element.
  local indicator="…"

  # -----------------------------------------------------------------------------

  local OPT OPTIND OPTARG
  while getopts ':d:l:k:c:i:' OPT; do
    case $OPT in
      d)  min_depth="$OPTARG" ;;
      l)  max_length="$OPTARG" ;;
      k)  keep_dirs="$OPTARG" ;;
      c)  keep_chars="$OPTARG" ;;
      i)  indicator="$OPTARG" ;;
    '?')
          echo >&2 "-$OPTARG: invalid option"
          return 1
                   ;;
    esac
  done
  shift $((OPTIND - 1))

  # Sanity check
  # [[ $min_depth -le $keep_dirs ]] && min_depth=$keep_dirs
  # [[ $keep_dirs -gt $min_depth ]] && min_depth=$keep_dirs

  # ---------------------------------------------------------------------------

  # Get present working directory from invocation or environment.
  local input=${*:-$PWD}

  # Tilde-ify home directory if present.
  input="${input/#$HOME/$'~'}"

  # Use the slash as a separator to split PWD into an array of its elements.
  local -a in_parts
  IFS=/ read -r -a in_parts <<<"${input}"

  # If PWD is under HOME, in_parts[0] will contain the leading tilde;
  # otherwise, it will be empty.
  case ${in_parts[0]} in
    "~")  # Because a leading tilde is so short, it doesn't count when
          # determining minimum depth.
          ((min_depth++))
          ;;
    "")   # PWD starts at root; remove the empty element from the array.
          unset "in_parts[0]"
          ;;
  esac

  # Are there enough elements/characters to warrant compression?
  if [[ ${#in_parts[@]} -lt $min_depth ]] && [[ ${#input} -lt $max_length ]]; then
    # PWD is already short; just return what we were given.
    printf "%s" "$input"
    return
  else
    # Collect the trailing elements that will not be compressed.
    local -a end_parts=()
    local n; for (( n = keep_dirs; n > 0; n-- )); do
      end_parts+=("${in_parts[-$n]}")
    done

    # The stopping point required to preserve uncompressed trailing elements.
    local stop_index=$((${#in_parts[@]} - ${#end_parts[@]}))

    if [[ -z ${in_parts[0]} ]]; then
      ((stop_index++))
    fi

    # Iterate through the remaining elements, stopping where required.
    local -a out_parts=()
    local i; for ((i = 1; i < stop_index; i++)); do
      local part="${in_parts[$i]}"

      # No need to compress elements that are already <= $keep_chars long.
      if [[ ${#part} -gt $keep_chars ]]; then
          part="${part:0:keep_chars}${indicator}"
      fi

      # Add the result to the array of compressed elements.
      out_parts+=("${part}")
    done

    # Print all of the compressed elements, then all of the uncompressed
    # trailing elements, each preceded by a slash.
    if [[ ${in_parts[0]} == "~" ]]; then
      printf "%s" "~"
    fi
    printf "/%s" "${out_parts[@]}" "${end_parts[@]}"
  fi
}

# Notify Terminal.app (or mintty) of the current directory
# Based on: /etc/bashrc_Apple_Terminal (El Capitan)
_z_PS1_update_cwd()
{
  local ante="${DCS_ante}${OSC}7;"
  local post="${BEL}${DCS_post}"

  if [[ $HOSTNAME != *.* ]]; then
    local HOSTNAME; HOSTNAME="$(uname -n)"
  fi

  # Format: file://hostname/path/to/pwd
  local pwd_url="file://${HOSTNAME}"

  {
    # ensure text is processed byte-by-byte
    local LC_CTYPE=C LC_ALL=

    local i ch hexch
    for ((i = 0; i < ${#PWD}; i++)); do
      ch=${PWD:i:1}
      if [[ $ch =~ [[:alnum:]/._~-] ]]; then
        pwd_url+="$ch"
      else
        printf -v hexch "%02X" "'$ch"
        # interpret as number ──┘

        # printf treats values > 127 as negative
        # and pads w/ 'FF', so truncate
        pwd_url+="%${hexch: -2:2}"
      fi
    done
  }

  printf '%b' "$ante" "$pwd_url" "$post"
}

_z_PS1_update_titles()
{
  # Window title, e.g. "user@Hostname.local: ~/share/man/man1"
  local win_title="${USER}@${HOSTNAME}: ${PWD/#$HOME/$'~'}"

  # Tab title, e.g. "Athena: ~/…/man1"
  if [[ ${BASH_VERSINFO[0]}${BASH_VERSINFO[1]} -ge 44 ]]; then
    local PROMPT_DIRTRIM=1
    local pwd
    pwd='\w'
    pwd=${pwd@P}
    pwd=${pwd//.../…}
  else
    pwd=${PWD##*/}
  fi

  local tab_title="${SSH_CONNECTION+${HOSTNAME%%.*}: }${pwd}"

  [[ $Z_SET_WINTITLE == true ]] && setwintitle "$win_title"
  [[ $Z_SET_TABTITLE == true ]] && settabtitle "$tab_title"
}

# -----------------------------------------------------------------------------
# colours
# -----------------------------------------------------------------------------

if [[ $Z_PROMPT_COLOUR == true ]]; then
  # root gets red prompt
  if [[ $EUID -eq 0 ]]; then
    esc_user=${esc_brred}
  fi

  # Create new colour variables w/ prompt escape codes (\[ and \])
  _z_PS1_esc_colours()
  {
    local -a indexes=("$@")
    local index

    # $esc_green -> $PS1_green, $esc_true -> $PS1_true
    for index in "${indexes[@]}"; do
      local name="PS1_${index#*_}"

      if [[ -n ${!index} && -z ${!name} ]] || [[ $Z_RELOADING == true ]]; then
        printf -v "$name" '\[%s\]' "${!index}"
      fi
    done
  }
  # Leaving this unquoted so it expands properly.
  # shellcheck disable=SC2086
  _z_PS1_esc_colours ${!esc_*}
  unset -f _z_PS1_esc_colours
fi

# -----------------------------------------------------------------------------
# PS1
# -----------------------------------------------------------------------------

PS1=""

# Print the hostname if we're remotely connected (otherwise we probably know
# which machine we're sitting in front of), and the username if it's not the
# one we usually log in with.
if [[ -n $SSH_CONNECTION || $Z_PROMPT_HOST == true ]]; then
  case $USER in
    "$PRIMARY_USER")
      PS1+="${PS1_dim}"
      ;;
    *)
      PS1+="${PS1_dim}\\u@"
      ;;
  esac
  PS1+="\\h${PS1_reset}:"
fi

# Print the current path, highlighted
PS1+="${PS1_hi}\\w${PS1_reset}"

# § for me, # for root
if [[ $EUID -eq 0 ]]; then
  PS1+=" ${PS1_user}#"
elif [ "$ITERM_PROFILE" = "ANSI" ]; then
  PS1+=" ${PS1_user}$"
else
  PS1+=" ${PS1_user}§"
fi

PS1+="${PS1_reset} "

# -----------------------------------------------------------------------------
# PS2-4
# -----------------------------------------------------------------------------

# Secondary prompt for multi-line commands = right-facing guillemet (»)
PS2="${PS1_user}"$'\xC2\xBB'"${PS1_reset} "

# Prompt for the `select` builtin = question mark
PS3="${PS1_blue}?${PS1_reset} "

# Prefix for `set -o xtrace` output
PS4="+ "
PS4+="\${BASH_SOURCE:+$PS1_dim\${BASH_SOURCE/#\$HOME/'~'}$PS1_reset}"
PS4+="\${BASH_SOURCE+:$PS1_blue\$LINENO$PS1_reset:}"
PS4+="$PS1_italic\$BASH_COMMAND$PS1_reset"
PS4+=$'\n    '

# -----------------------------------------------------------------------------
# PROMPT_COMMAND
# -----------------------------------------------------------------------------

_z_prompt_cmd_add()
{ # append (or prepend with -p) to PROMPT_COMMAND, avoiding duplicates
  local regex=" ?${*}[ ;]*"

  if [[ $1 == -p ]]; then
    local prepend=true
    shift
  fi

  local cmd="$*"

  if [[ ! $PROMPT_COMMAND =~ $regex ]]; then
    if [[ $prepend == true ]]; then
      PROMPT_COMMAND="${cmd}${PROMPT_COMMAND:+;}${PROMPT_COMMAND}"
    else
      PROMPT_COMMAND+="${PROMPT_COMMAND:+;}${cmd}"
    fi
  fi

  return 0
}

# append to HISTFILE
_z_prompt_cmd_add -p "history -a"
_z_prompt_cmd_add _z_PS1_update_cwd
_z_prompt_cmd_add _z_PS1_update_titles

unset -f _z_prompt_cmd_add
