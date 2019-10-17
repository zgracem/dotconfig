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

# If true, print the exit status of the last command aligned right in red
: "${Z_PROMPT_EXIT:=true}"

# If true, make a slow call to `git` every time the prompt refreshes,
# in exchange for info about the current git situation ("gituation")
: "${Z_PROMPT_GIT:=true}"

# If false, display the hostname in the prompt only when connected via SSH.
# If true, always display the hostname in the prompt, even in local sessions.
: "${Z_PROMPT_HOST:=false}"

# If true, the prompt will display an indication of any active jobs
: "${Z_PROMPT_JOBS:=true}"

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
if (( TERM_COLOURDEPTH < 8 )); then
  Z_PROMPT_COLOUR=false
fi

# Only change window title if supported by current terminal
if [[ ! $PTERM =~ ^(xterm|putty|nsterm|iTerm) ]]; then
  Z_SET_WINTITLE=false
  Z_SET_TABTITLE=false
fi

case $TERM_PROGRAM in
  PuTTY) # doesn't have meaningful "tab titles"
    Z_SET_TABTITLE=false
    ;;
  Prompt*) # doesn't have a status line (panic.com/prompt)
    Z_SET_WINTITLE=false
    Z_SET_TABTITLE=false
    ;;
  Coda) # has a very narrow status line (panic.com/coda-ios)
    Z_SET_WINTITLE=false
    Z_SET_TABTITLE=false
    ;;
  Apple_Terminal) # has its own functions for this
    Z_SET_WINTITLE=false
    Z_SET_TABTITLE=false
    ;;
esac

# Display "user@hostname" if "user" isn't typical
#   (set in ~/.private/environment.d/default_user.sh)
if [[ $USER != "$DEFAULT_USER" ]]; then
  Z_PROMPT_HOST=true
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
    '?')  scold "-$OPTARG: invalid option"
          return 1 ;;
    esac
  done
  shift $((OPTIND - 1))

  # Sanity check
  # (( min_depth <= keep_dirs )) && min_depth=$keep_dirs
  # (( keep_dirs > min_depth )) && min_depth=$keep_dirs

  # ---------------------------------------------------------------------------

  # Get present working directory from invocation or environment.
  local input=${*:-$PWD}

  # Tilde-ify home directory if present.
  input="${input/#$HOME/$'~'}"

  # Use the slash as a separator to split PWD into an array of its elements.
  local -a in_parts
  IFS=/ read -r -a in_parts <<< "${input}"

  # If PWD is under HOME, in_parts[0] will contain the leading tilde;
  # otherwise, it will be empty.
  case ${in_parts[0]} in
    "~")  # Because a leading tilde is so short, it doesn't count when
          # determining minimum depth.
          (( min_depth++ ))
          ;;
    "")   # PWD starts at root; remove the empty element from the array.
          unset "in_parts[0]"
          ;;
  esac

  # Are there enough elements/characters to warrant compression?
  if (( ${#in_parts[@]} < min_depth )) \
    && (( ${#input} < max_length ))
  then
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
    local stop_index=$(( ${#in_parts[@]} - ${#end_parts[@]} ))

    if [[ -z ${in_parts[0]} ]]; then
      (( stop_index++ ))
    fi

    # Iterate through the remaining elements, stopping where required.
    local -a out_parts=()
    local i; for (( i = 1; i < stop_index; i++ )); do
      local part="${in_parts[$i]}"

      # No need to compress elements that are already <= $keep_chars long.
      if (( ${#part} > keep_chars )); then
          part="${part:0:$keep_chars}${indicator}"
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

_z_PS1_print_exit()
{ # Print non-zero exit codes on the far right of the screen (zsh envy...)
  local last_exit=$?
  local gutter=1
  local sigspec

  [[ $Z_PROMPT_EXIT == true ]] || return $last_exit
  [[ $1 =~ ^[[:digit:]]+$ ]] && last_exit=$1
  (( last_exit == 0 )) && return 0

  # If terminated from a signal (128 >= $? >= 165), get signal name from `kill`
  # (`-l` = list) and print that instead.
  if (( last_exit > 128 )) && sigspec=$(builtin kill -l "$last_exit" 2>/dev/null); then
    last_exit=${sigspec#SIG}
  elif (( last_exit >= 64 && last_exit <= 78 )); then
    # Someone's been reading sysexits(3)... ;)
    local -ra exits=( [64]="USAGE"    [65]="DATAERR"     [66]="NOINPUT"
      [67]="NOUSER"   [68]="NOHOST"   [69]="UNAVAILABLE" [70]="SOFTWARE"
      [71]="OSERR"    [72]="OSFILE"   [73]="CANTCREAT"   [74]="IOERR"
      [75]="TEMPFAIL" [76]="PROTOCOL" [77]="NOPERM"      [78]="CONFIG" )
    last_exit=${exits[$last_exit]}
  fi

  local screen_dimensions; read -r -a screen_dimensions < <(stty size)
  local screen_width=${screen_dimensions[1]}
  local padding=$(( screen_width - gutter ))

  # print exit code & return to beginning of line
  printf '%*s\r' $padding "$last_exit"
}

_z_PS1_git_info()
{
  [[ $Z_PROMPT_GIT != true ]] && return

  local status="" branch="" icons=""
  local ahead=0 behind=0 unstaged=0 untracked=0 dirty=false

  # bail immediately if we're not in a git repo
  git rev-parse --is-inside-work-tree &>/dev/null || return

  # get info on current branch
  status=$(git status --branch --porcelain 2>/dev/null)

  # get name of branch
  local re_br='^## ([[:graph:]]+)…'
  if [[ ${status/.../…} =~ $re_br ]]; then
    branch="${BASH_REMATCH[1]}"
  elif [[ $status =~ ${re_br%…} ]]; then
    branch="${BASH_REMATCH[1]}"
  else
    return 1
  fi

  # count unstaged files (by counting newlines)
  unstaged=${status//[^$'\n']/}
  unstaged=${#unstaged}

  # count untracked files
  local re_ut=$'\n''(\? | \?|\?\?)'
  if [[ $status =~ $re_ut ]]; then
    untracked=$(( ${#BASH_REMATCH[@]} - 1 ))
  fi

  if (( unstaged > 0 )) || (( untracked > 0 )); then
    dirty=true
  fi

  # get commits ahead (if any)
  local re_ah='\[ahead ([[:digit:]]+)'
  if [[ $status =~ $re_ah ]]; then
    ahead="${BASH_REMATCH[1]}"
  fi

  # get commits behind (if any)
  local re_bh='behind ([[:digit:]]+)\]'
  if [[ $status =~ $re_bh ]]; then
    behind="${BASH_REMATCH[1]}"
  fi

  # add '*' if there's anything to commit
  if [[ $dirty == true ]]; then
    icons+=${esc_reset:-}
    icons+=${esc_false:-}
    icons+="*"
  fi

  # # add '*' if there are untracked files
  # if (( untracked > 0 )); then
  #   icons+=${esc_reset:-}
  #   icons+=${esc_green:-}
  #   icons+="*"
  # fi

  # add '+' if we're ahead of origin, '−' if behind, '±' if both
  if (( (ahead + behind) > 0 )); then
    icons+=${esc_reset:-}
    icons+=${esc_yellow:-}
    if (( ahead > 0 )) && (( behind == 0 )); then
      icons+="+"
    elif (( ahead == 0 )) && (( behind > 0 )); then
      icons+="−"
    elif (( ahead > 0 )) && (( behind > 0 )); then
      icons+='±'
    fi
  fi

  printf "${esc_reset}%b" \
    " ${esc_dim}${branch}" \
    "${icons-}${esc_reset}"
}

_z_PS1_jobs()
{
  [[ $Z_PROMPT_JOBS != true ]] && return

  local jobs; jobs="$(jobs)"
  [[ -n $jobs ]] || return

  # count newlines
  jobs="${jobs//[^$'\n']/}"
  local job_count=$(( ${#jobs} + 1 )) # no trailing newline at EOT

  if (( job_count > 0 )); then
    printf ' %d' "${job_count}"
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
    for (( i = 0; i < ${#PWD}; i++ )); do
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
  if (( ${BASH_VERSINFO[0]}${BASH_VERSINFO[1]} >= 44 )); then
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
  if (( EUID == 0 )); then
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

# Print exit status of last command. This has to come first for two reasons:
# 1) So the last exit status doesn't get overwritten by anything else in the
# prompt; and 2) so the tput calls in `_z_PS1_print_exit` get made before
# anything else is printed.
if [[ $Z_PROMPT_EXIT == true ]]; then
  PS1+="${PS1_false}\\[\$(_z_PS1_print_exit)\\]${PS1_reset}"
fi

# Print the hostname if we're remotely connected (otherwise we probably know
# which machine we're sitting in front of), and the username if it's not the
# one we usually log in with.
if [[ -n $SSH_CONNECTION || $Z_PROMPT_HOST == true ]]; then
  case $USER in
    $DEFAULT_USER)
      PS1+="${PS1_dim}"
      ;;
    *)
      PS1+="${PS1_dim}\\u@"
      ;;
  esac
  PS1+="\\h${PS1_reset}:"
fi

# Print the current path, highlighted and truncated if necessary.
PS1+="${PS1_hi}\$(_z_PS1_compress_pwd)${PS1_reset}"

# info about current git branch, if any (function supplies colours)
PS1+="\$(_z_PS1_git_info)"

# number of background jobs, if any
PS1+="${PS1_yellow}\$(_z_PS1_jobs)${PS1_reset}"

# § for me, # for root, ? if we're in incognito mode
if [[ -n $Z_INCOGNITO ]]; then
  PS1+=" ${PS1_brblack}?"
elif (( EUID == 0 )); then
  PS1+=" ${PS1_user}#"
else
  # PS1+=" ${PS1_user}\\\$"
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

_z_prompt_cmd_del()
{ # remove a command from PROMPT_COMMAND
  local regex=" ?${*}[ ;]*"

  if [[ $PROMPT_COMMAND =~ $regex ]]; then
    # capture command + any leading space + trailing semicolon
    local cmd=${BASH_REMATCH[0]}

    # remove that from existing PROMPT_COMMAND
    PROMPT_COMMAND=${PROMPT_COMMAND/$cmd/}

    # remove any orphaned trailing semicolon
    PROMPT_COMMAND=${PROMPT_COMMAND%;}
  fi
}

# -----------------------------------------------------------------------------

if [[ $TERM_PROGRAM == iTerm.app ]]; then
  _z_prompt_cmd_add iterm::state
fi

if [[ $TERM_PROGRAM == Apple_Terminal || $TERM_PROGRAM == mintty ]]; then
  _z_prompt_cmd_add _z_PS1_update_cwd
else
  unset -f _z_PS1_update_cwd
fi

if [[ $Z_SET_WINTITLE == true || $Z_SET_TABTITLE == true ]]; then
  _z_prompt_cmd_add _z_PS1_update_titles
fi

# append to HISTFILE
_z_prompt_cmd_add -p "history -a"

# # read from HISTFILE -- enable if you want tmux sessions to share history
# _z_prompt_cmd_add -p "history -n"

# -----------------------------------------------------------------------------
# cleanup
# -----------------------------------------------------------------------------

unset -f _z_prompt_cmd_{add,del}
# unset -v ${!PS1_*}

# -----------------------------------------------------------------------------
# control function
# -----------------------------------------------------------------------------

# Requires bash 4+ (case fall-through)
(( BASH_VERSINFO[0] >= 4 )) || return

prompt()
{
  local var="Z_PROMPT_${1^^}"

  if [[ -n ${!var} ]]; then
    if [[ ${!var} == true ]]; then
      printf -v "$var" "false"
    else
      printf -v "$var" "true"
    fi

    if [[ ${1,,} == host ]]; then
      rl prompt
    fi

    echo "$var=${!var}"
  elif [[ -n $1 ]]; then
    # Ignore shellcheck warnings; bash 4+ supports case fall-through
    # shellcheck disable=SC2221,SC2222
    case ${1,,} in
      reset)
        # Leaving this unquoted so it expands properly.
        # shellcheck disable=SC2086
        unset -v ${!Z_PROMPT_*}
        ;;&
      reset|on)
        rl prompt
        ;;
      off)
        unset PS0
        PS1='\$ '
        PS2='> '
        PS3='? '
        PS4='+ '
        ;;
      help|*)
        local -a opts; read -r -a opts <<< "on off reset ${!Z_PROMPT_*}"
        local options="${opts[*]##*_}"
        options="${options,,}"
        echo "Usage: ${FUNCNAME[0]} [${options// /|}]"
        ;;
    esac
  else
    local p v; for p in PS{0..4}; do v=${!p}
      printf '%s=%q\n' "$p" "$v"
    done
  fi
}
