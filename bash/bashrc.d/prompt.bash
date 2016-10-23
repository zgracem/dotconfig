# -----------------------------------------------------------------------------
# ~/.config/bash/bashrc.d/prompt.bash
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
: ${Z_PROMPT_COLOUR:=true}

# If true, print the exit status of the last command aligned right in red
: ${Z_PROMPT_EXIT:=true}

# If true, make a slow call to `git` every time the prompt refreshes,
# in exchange for info about the current git situation ("gituation")
: ${Z_PROMPT_GIT:=false}

# If false, display the hostname in the prompt only when connected via SSH.
# If true, always display the hostname in the prompt, even in local sessions.
: ${Z_PROMPT_HOST:=false}

# If true, the prompt will display an indication of any active jobs
: ${Z_PROMPT_JOBS:=true}

# If true, set window/tab title to "host@username: pwd"
: ${Z_SET_WINTITLE:=true}
: ${Z_SET_TABTITLE:=false}

export ${!Z_PROMPT_*} ${!Z_SET_*}

# -----------------------------------------------------------------------------
# Sanity checks for features
# -----------------------------------------------------------------------------

# Only use colours if supported by current terminal
if (( TERM_COLOURDEPTH < 8 )); then
  Z_PROMPT_COLOUR=false
fi

# Only change window title if supported by current terminal
if [[ ! $PTERM =~ xterm|putty|nsterm|iTerm ]]; then
  Z_SET_WINTITLE=false
  Z_SET_TABTITLE=false
fi

# Prompt (panic.com/prompt) doesn't have a status line
if [[ $TERM_PROGRAM == Prompt* ]]; then
  Z_SET_WINTITLE=false
  Z_SET_TABTITLE=false
fi

# Coda (panic.com/coda-ios) has a very narrow status line
if [[ $TERM_PROGRAM == Coda ]]; then
  Z_SET_WINTITLE=false
  Z_SET_TABTITLE=false
fi

# Terminal.app has its own functions for this
if [[ $TERM_PROGRAM == Apple_Terminal ]]; then
  Z_SET_WINTITLE=false
  Z_SET_TABTITLE=false
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

  # Compress if PWD has >= `$min_depth` elements (not counting `~`, if any).
  local min_depth=5

  # Compress if PWD is >= `$max_pwd_length` chars long (overrides `min_depth`).
  local max_pwd_length=54

  # Always retain the full names of the last `$keep_dirs` elements.
  local keep_dirs=1

  # When compressing a directory name, keep the first `$keep_chars` characters.
  local keep_chars=3

  # Append `$indicator` to each compressed element.
  local indicator="…"

  # ---------------------------------------------------------------------------

  # Get present working directory from invocation or environment.
  local input=${@:-$PWD}

  # Tilde-ify home directory if present.
  input="${input/#$HOME/$'~'}"

  # Use the slash as a separator to split PWD into an array of its elements.
  local -a in_parts
  IFS=/ read -a in_parts <<< "${input}"

  # If PWD is under HOME, in_parts[0] will contain the leading tilde;
  # otherwise, it will be empty.
  case ${in_parts[0]} in
    "~")  # Because a leading tilde is so short, it doesn't count when
          # determining minimum depth.
          (( min_depth++ ))
          ;;
    "")   # PWD starts at root; remove the empty element from the array.
          unset in_parts[0]
          ;;
  esac

  # Are there enough elements/characters to warrant compression?
  if (( ${#in_parts[@]} < ${min_depth} )) \
      && (( ${#input} < ${max_pwd_length} )); then
    # PWD is already short; just return what we were given.
    printf "%s" "$input"
    return
  else
    # Collect the trailing elements that will not be compressed.
    local -a end_parts=()
    local n; for (( n = ${keep_dirs}; n > 0; n-- )); do
      end_parts+=("${in_parts[-$n]}")
    done

    # The stopping point required to preserve uncompressed trailing elements.
    local stop_index=$(( ${#in_parts[@]} - ${#end_parts[@]} ))

    # Iterate through the remaining elements, stopping where required.
    local -a out_parts=()
    local i; for (( i = 1; i < ${stop_index}; i++ )); do
      local part="${in_parts[$i]}"

      # No need to compress elements that are already <= $keep_chars long.
      # Nor should we "compress" unless there would actually be a net decrease
      # in length; i.e. don't turn "user" (4 chars) into "use…" (4 chars).
      if (( ${#part} > (${keep_chars} + ${#indicator}) )); then
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
  (( last_exit != 0 )) || return 0

  # If terminated from a signal (128 >= $? >= 165), get signal name from `kill`
  # (`-l` = list) and print that instead.
  if (( last_exit > 128 )) && sigspec=$(builtin kill -l $last_exit 2>/dev/null); then
    last_exit=${sigspec#SIG}
  elif (( last_exit >= 64 && last_exit <= 78 )); then
    # Someone's been reading `/usr/include/sysexits.h`... ;)
    local -ra exits=( [64]="USAGE"    [65]="DATAERR"     [66]="NOINPUT"
      [67]="NOUSER"   [68]="NOHOST"   [69]="UNAVAILABLE" [70]="SOFTWARE"
      [71]="OSERR"    [72]="OSFILE"   [73]="CANTCREAT"   [74]="IOERR"
      [75]="TEMPFAIL" [76]="PROTOCOL" [77]="NOPERM"      [78]="CONFIG" )
    last_exit=${exits[$last_exit]}
  fi

  local screen_width=${COLUMNS:-$(tput cols)}
  local padding=$(( screen_width - gutter ))

  # print exit code & return to beginning of line
  printf "%*s\r" $padding "$last_exit"
}

_z_PS1_git_info()
{
  [[ $Z_PROMPT_GIT != true ]] && return

  local status="" branch="" icons=""
  local ahead=0 unstaged=0 untracked=0 dirty=false

  # get info on current branch, or bail if no branch exists
  status=$(git status --branch --porcelain 2>/dev/null) || return

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
  unstaged=${status//[^$'\x0a']/}
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
  local re_ah=' \[ahead ([[:digit:]]+)\]'
  if [[ $status =~ $re_ah ]]; then
    ahead="${BASH_REMATCH[1]}"
  fi

  # add '*' if there's anything to commit
  if [[ $dirty == true ]]; then
    icons+=$esc_reset
    icons+=$esc_false
    icons+="*"
  fi

  # add '+' if there are untracked files
  if (( untracked > 0 )); then
    icons+=$esc_reset
    icons+=$esc_green
    icons+="+"
  fi

  # add '»' if we're ahead of origin
  if (( ahead > 0 )); then
    icons+=$esc_reset
    icons+=$esc_yellow
    icons+="»"
  fi

  printf "${esc_reset}%b" \
    " ${esc_dim}${branch}" \
    "${icons-}${esc_reset}"
}

_z_PS1_jobs()
{
  [[ $Z_PROMPT_JOBS != true ]] && return

  if (( ${BASH_VERSINFO[0]}${BASH_VERSINFO[1]} >= 44 )); then
    # Use bash-4.4's prompt-expanding parameter transformation
    local jobs='\j'
    local job_count="${j@P}"
  else
    # Get output from `jobs` builtin
    local jobs="$(jobs)"
    [[ -n $jobs ]] || return

    # count newlines
    jobs="${jobs//[^$'\n']/}"
    local job_count="${#jobs}"
  fi

  if (( job_count > 0 )); then
    printf ' %d' "${job_count}"
  fi
}

# Notify iTerm of the current directory
_z_PS1_update_iTerm()
{
  iterm::state
}

# Notify Terminal.app of the current directory
# Based on: /etc/bashrc_Apple_Terminal (El Capitan)
_z_PS1_update_Terminal()
{
  local ante="${DCS_ante}${OSC}7;" 
  local post="${BEL}${DCS_post}"

  if [[ $HOSTNAME != *.* ]]; then
    local HOSTNAME="$(uname -n)"
  fi

  # Format: file://hostname/path/to/pwd
  local pwd_url="file://${HOSTNAME}"

  {
    # ensure text is processed byte-by-byte
    local LC_CTYPE=C LC_ALL=

    local i ch hexch
    for (( i = 0; i < ${#PWD}; i++ )); do
      ch=${PWD:i:1}
      if [[ $ch =~ [/._~A-Za-z0-9-] ]]; then
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
  # Window title, e.g. "zozo@Athena.local: /usr/bin"
  local win_title="${USER}@${HOSTNAME}: ${PWD/#$HOME/$'~'}"
  # Tab title, e.g. "Athena: bin"
  local tab_title="${HOSTNAME%%.*}: ${PWD##*/}"

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
        printf -v $name "\[${!index}\]"
      fi
    done
  }
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
  PS1+="${PS1_false}\[\$(_z_PS1_print_exit)\]${PS1_reset}"
fi

# Print the hostname if we're remotely connected. (Otherwise we probably know
# which machine we're sitting in front of.)
if [[ -n $SSH_CONNECTION || $Z_PROMPT_HOST == true ]]; then
  PS1+="${PS1_dim}\h${PS1_reset}:"
fi

# Print the current path, highlighted and truncated if necessary.
PS1+="${PS1_hi}\$(_z_PS1_compress_pwd)${PS1_reset}"

# info about current git branch, if any (function supplies colours)
PS1+="\$(_z_PS1_git_info)"

# number of background jobs, if any
PS1+="${PS1_yellow}\$(_z_PS1_jobs)${PS1_reset}"

# $ for me, # for root, ? if we're in incognito mode
if [[ -n $Z_INCOGNITO ]]; then
  PS1+=" ${PS1_brblack}?"
else
  PS1+=" ${PS1_user}\\\$"
fi

PS1+="${PS1_reset} "

# -----------------------------------------------------------------------------
# PS0,2-4
# -----------------------------------------------------------------------------

# Secondary prompt for multi-line commands = right-facing guillemet (»)
PS2="${PS1_user}"$'\xC2\xBB'"${PS1_reset} "

# Prompt for the `select` builtin = question mark
PS3="${PS1_blue}?${PS1_reset} "

# Prefix for `set -o xtrace` output
PS4="+ "
PS4+="\${BASH_SOURCE+$PS1_dim\${BASH_SOURCE/#\$HOME/'~'}$PS1_reset}"
PS4+="\${BASH_SOURCE+:$PS1_blue\$LINENO$PS1_reset:}"
PS4+="$PS1_italic\$BASH_COMMAND$PS1_reset"
PS4+=$'\n\t'

# -----------------------------------------------------------------------------
# PROMPT_COMMAND
# -----------------------------------------------------------------------------

_z_prompt_cmd_add()
{ # append (or prepend with -p) to PROMPT_COMMAND, avoiding duplicates
  local regex=' ?'"$*"'[ ;]*'

  if [[ $1 == -p ]]; then
    local prepend=true
    shift
  fi

  local cmd="$@"

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
  local regex=' ?'"$*"'[ ;]*'

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
  _z_prompt_cmd_add _z_PS1_update_iTerm
else
  unset -f _z_PS1_update_iTerm
fi

if [[ $TERM_PROGRAM == Apple_Terminal ]]; then
  _z_prompt_cmd_add _z_PS1_update_Terminal
else
  unset -f _z_PS1_update_Terminal
fi

if [[ $Z_SET_WINTITLE == true || $Z_SET_TABTITLE == true ]]; then
  _z_prompt_cmd_add _z_PS1_update_titles
fi

# append to HISTFILE
_z_prompt_cmd_add -p "history -a"

# # read from HISTFILE -- enable if you want tmux sessions to share history
# _z_prompt_cmd_add -p "history -n"

# -----------------------------------------------------------------------------
# control function
# -----------------------------------------------------------------------------

prompt()
{
  local var="Z_PROMPT_${1^^}"

  if [[ -n ${!var} ]]; then
    if [[ ${!var} == true ]]; then
      printf -v $var "false"
    else
      printf -v $var "true"
    fi
    
    if [[ ${1,,} == host ]]; then
      rl prompt
    fi

    echo "$var=${!var}"
  elif [[ -n $1 ]]; then
    case ${1,,} in
      reset)
        unset -v ${!Z_PROMPT_*}
        ;;&
      reset|on)
        rl prompt
        ;;
      off)
        unset PS0
        PS1="\$ "
        PS2="> "
        PS3="? "
        PS4="+ "
        ;;
      help|*)
        local -a opts=( on off reset ${!Z_PROMPT_*} )
        opts="${opts[@]##*_}"
        opts="${opts,,}"
        echo "Usage: $FUNCNAME [${opts// /|}]"
        ;;
    esac
  elif (( ${BASH_VERSINFO[0]}${BASH_VERSINFO[1]} >= 44 )); then
    local p v; for p in PS{0..4}; do v=${!p}
      echo "$p=${v@Q}"
    done
  fi
}

# -----------------------------------------------------------------------------
# cleanup
# -----------------------------------------------------------------------------

unset -f _z_prompt_cmd_{add,del}
unset -v ${!PS1_*}
