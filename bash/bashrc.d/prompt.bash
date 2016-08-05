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

: ${Z_PROMPT_COLOUR:=true}
: ${Z_PROMPT_EXIT:=true}
: ${Z_PROMPT_GIT:=false}

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
if [[ ! $TERM =~ xterm|screen|tmux|cygwin|putty|iTerm.app ]]; then
  Z_SET_WINTITLE=false
  Z_SET_TABTITLE=false
fi

# Prompt <panic.com/prompt> doesn't have a status line
if [[ $TERM_PROGRAM =~ ^Prompt ]]; then
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

_z_prompt_compress_pwd()
{ # Usage: _z_prompt_compress_pwd "$PWD"

  # Trims leading elements of the current directory like so:
  #   ~/first/second/3rd/fourth
  #   ~/fir…/sec…/3rd/fourth/fifth
  #   ~/fir…/sec…/3rd/fourth/fifth/sixth
  #   ~/fir…/sec…/3rd/fou…/fifth/sixth/seventh

  # Compress if PWD has __ or more elements (not counting `~`).
  local min_depth=4

  # Compress if PWD is __ or more characters long. (Overrides $min_depth.)
  local max_length=50

  # Always retain the full names of the last __ elements.
  local keep_dirs=2

  # When compressing a directory element, keep the first __ characters.
  local keep_chars=3

  # Append __ to each trimmed element to indicate it has been compressed.
  local indicator="…"

  # ---------------------------------------------------------------------------

  # Get present working directory from invocation or environment.
  local input=${@:-$PWD}

  # Tilde-ify home directory if present.
  input="${input/#$HOME/$'~'}"

  # Because a leading tilde is so short, it doesn't count for the purposes of
  # determining minimum depth.
  if [[ ${input:0:1} == "~" ]]; then
    (( min_depth++ ))
  fi

  # Use the slash as a separator to split PWD into an array of its elements.
  local -a input_parts
  IFS=/ read -a input_parts <<< "${input}"

  # If PWD is under HOME, input_parts[0] will contain the leading tilde;
  # otherwise, it will be empty, and should be removed from the array.
  if [[ ${input_parts[0]} == "" ]]; then
    unset input_parts[0]
  fi

  # Are there enough elements/characters to warrant compression?
  if (( ${#input_parts[@]} > ${min_depth} )) || (( ${#input} > ${max_length} )); then
    # Collect the trailing elements that will not be compressed.
    local -a trailing_parts=()
    local n; for (( n = ${keep_dirs}; n > 0; n-- )); do
      trailing_parts+=("${input_parts[-$n]}")
    done

    # The stopping point required to preserve uncompressed trailing elements.
    local stop_index=$(( ${#input_parts[@]} - ${#trailing_parts[@]} ))

    # Iterate through the remaining elements, stopping where required.
    local -a output_parts=()
    local i; for (( i = 1; i < ${stop_index}; i++ )); do
      local part="${input_parts[$i]}"

      # No need to compress elements that are already short. Note: If the
      # indicator would replace only trimmed character(s), for a zero net
      # decrease in length (i.e., "user" -> "use…"), the element will not be
      # trimmed.
      if (( ${#part} > (${keep_chars} + ${#indicator}) )); then
          part="${part:0:$keep_chars}${indicator}"
      fi

      # Add the result to the array of compressed elements.
      output_parts+=("${part}")
    done

    # Print all of the compressed elements, then all of the uncompressed
    # trailing elements, each preceded by a slash.
    printf "/%s" "${output_parts[@]}" "${trailing_parts[@]}"
  else
    # PWD is too short to warrant compression; just return what we were given.
    printf "%s" "$input"
  fi
}

_z_prompt_print_exit()
{ # Print non-zero exit codes on the far right of the screen (zsh envy...)
  local last_exit=$?
  local gutter=1
  local sigspec

  if (( last_exit != 0 )); then
    # abort if tput doesn't exist
    type -P tput &>/dev/null || return

    # If terminated from a signal (128 >= $? >= 165), get signal name from
    # builtin `kill -l` (list) and print that instead.
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

    # save cursor position
    tput sc

    # print exit code
    printf "%*s" $padding "$last_exit"

    # restore cursor position
    tput rc
  fi
}

_z_prompt_git_info()
{
  [[ $Z_PROMPT_GIT == true ]] || return 0

  local status= branch= icons=
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

  if (( unstaged > 0 )); then
    dirty=true
  fi

  # count untracked files
  local re_ut=$'\n''(\? | \?|\?\?)'
  if [[ $status =~ $re_ut ]]; then
    untracked=$(( ${#BASH_REMATCH[@]} - 1 ))
  fi

  if (( untracked > 0 )); then
    dirty=true
  fi

  # get commits ahead (if any)
  local re_ah=' \[ahead ([[:digit:]]+)\]'
  if [[ $status =~ $re_ah ]]; then
    ahead="${BASH_REMATCH[1]}"
  fi

  # # add '•' if there's anything to commit
  # if [[ $dirty == true ]]; then
  #   icons+=$esc_false
  #   icons+="•"
  # fi

  # # add '+' if there are untracked files
  # if (( untracked > 0 )); then
  #   icons+=$esc_reset
  #   icons+=$esc_green
  #   icons+="+"
  # fi

  # # add '»' if we're ahead of origin
  # if (( ahead > 0 )); then
  #   icons+=$esc_reset
  #   icons+=$esc_yellow
  #   icons+="»"
  # fi

  if [[ $dirty == true ]]; then
    icons+=$esc_false
    icons+="*"
  fi

  # printf "${esc_reset} %b" \
  #   "${esc_dim}${branch}" \
  #   "${icons:-}${esc_reset}"

  printf "${esc_reset} %b${esc_reset}" \
    "${esc_dim}${branch}${icons}"
}

# Notify iTerm of the current directory
if _isFunction iterm_state; then
  _z_prompt_update_iTerm() { iterm_state; }
else
  _z_prompt_update_iTerm()
  {
    printf '%b%s%b' "${OSC}50;CurrentDir=${PWD}${BEL}"
  }
fi

# Notify Terminal.app of the current directory
_z_prompt_update_Terminal()
{ # Format:   file://hostname/path/to/pwd
  # Based on: /etc/bashrc_Apple_Terminal (El Capitan)

  local ante="${OSC}7;" post="${BEL}"

  if _inTmux; then
    # ANSI device control string
    ante="${DCS}tmux;\e${ante}"
    post="${post}${ST}"
  fi

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
        # interpret as number ──┐
        printf -v hexch "%02X" "'$ch"

        # printf treats values > 127 as negative
        # and pads w/ 'FF', so truncate
        pwd_url+="%${hexch: -2:2}"
      fi
    done
  }

  printf '%b' "$ante" "$pwd_url" "$post"
}

_z_prompt_update_titles()
{
  local tab_title="${USER}@${HOSTNAME%%.*}"
  local win_title="${tab_title}: ${PWD/#$HOME/$'~'}"

  [[ $Z_SET_WINTITLE == true ]] && setwintitle "$win_title"
  [[ $Z_SET_TABTITLE == true ]] && settabtitle "$tab_title"
}

# -----------------------------------------------------------------------------
# colours
# -----------------------------------------------------------------------------

if [[ $Z_PROMPT_COLOUR == true ]]; then
  # root gets red prompt
  if (( EUID == 0 )); then
    esc_user=${esc_red}
  fi

  ### ZGM disabled 2016-07-09 -- ugly and distracting.
  # # Users in Administrators group get a red prompt too.
  # if [[ $OSTYPE == cygwin && -z $CYGWIN_ADMIN ]]; then
  #   # Sets CYGWIN_ADMIN to "true" or "false."
  #   . "$dir_config/bash/bashrc.d/cygwin.bash"
  # fi

  # if [[ $CYGWIN_ADMIN == true ]]; then
  #   esc_user=${esc_red}
  # fi

  z_colour_PS1_esc()
  { # create new colour variables w/ prompt escape codes (\[ and \])

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

  z_colour_PS1_esc ${!esc_*}
fi

# -----------------------------------------------------------------------------
# PS1
# -----------------------------------------------------------------------------

PS1=""

# Print exit status of last command
if [[ $Z_PROMPT_EXIT == true ]]; then
  PS1+="${PS1_false}\[\$(_z_prompt_print_exit)\]${PS1_reset}"
fi

if [[ -n $SSH_CONNECTION ]]; then
  # hostname
  PS1+="${PS1_dim}\h${PS1_reset}:"
fi

# current path, highlighted
PS1+="${PS1_hi}\$(_z_prompt_compress_pwd)"

# info about current git branch, if any (function supplies colours)
PS1+="\$(_z_prompt_git_info)"

# blue $ for me, red # for root
PS1+=" ${PS1_user}\\\$${PS1_reset} "

# -----------------------------------------------------------------------------
# PS0,2-4
# -----------------------------------------------------------------------------

[[ $Z_SET_WINTITLE == true ]] && PS0+="\$(setwintitle \"\u@\h: \w\")"
# [[ $Z_SET_TABTITLE == true ]] && PS0+="\$(settabtitle \"\u@\h\")"

# Secondary prompt for multi-line commands = right-facing guillemet (»)
PS2="${PS1_user}"$'\xC2\xBB'"${PS1_reset} "

# Prompt for the `select` builtin = question mark
PS3="${PS1_blue}?${PS1_reset} "

# Prefix for `set -o xtrace` output
PS4="+ $PS1_dim\${BASH_SOURCE+\${BASH_SOURCE/#\$HOME/'~'}:\$LINENO # }\$BASH_COMMAND\n  $PS1_reset"

# -----------------------------------------------------------------------------
# PROMPT_COMMAND
# -----------------------------------------------------------------------------

_z_prompt_cmd_add()
{ # append (or prepend with -p) to PROMPT_COMMAND, avoiding duplicates
  if [[ $1 == -p ]]; then
    local prepend=true
    shift
  fi

  local cmd="$@"

  if [[ ! $PROMPT_COMMAND =~ $cmd ]]; then
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
  _z_prompt_cmd_add _z_prompt_update_iTerm
else
  unset -f _z_prompt_update_iTerm
fi

if [[ $TERM_PROGRAM == Apple_Terminal ]]; then
  _z_prompt_cmd_add _z_prompt_update_Terminal
else
  unset -f _z_prompt_update_Terminal
fi

if [[ $Z_SET_WINTITLE == true || $Z_SET_TABTITLE == true ]]; then
  _z_prompt_cmd_add "_z_prompt_update_titles"
fi

# append to HISTFILE
_z_prompt_cmd_add -p "history -a"    

# # read from HISTFILE -- enable if you want tmux sessions to share history
# _z_prompt_cmd_add -p "history -n"  

# see bashrc.d/direnv.bash
if _isFunction _direnv_hook; then
  _z_prompt_cmd_add -p "_direnv_hook"
fi

# -----------------------------------------------------------------------------
# cleanup
# -----------------------------------------------------------------------------

unset -f z_colour_PS1_esc _z_prompt_cmd_{add,del}
unset -v ${!PS1_*} ${!z_PS1*}
