# -----------------------------------------------------------------------------
# ~/.config/bash/bashrc.d/prompt.bash
# -----------------------------------------------------------------------------
# setup
# -----------------------------------------------------------------------------

# prompt strings undergo parameter expansion and command substitution
shopt -s promptvars

# clear prompt-related variables so we can start fresh
unset -v PS{1..4}
unset -v PROMPT_COMMAND
unset -v PROMPT_DIRTRIM

# -----------------------------------------------------------------------------
# configuration
# -----------------------------------------------------------------------------

: ${Z_PROMPT_TYPE:=oneline}

: ${Z_PROMPT_COLOUR:=true}
: ${Z_PROMPT_EXIT:=true}
: ${Z_PROMPT_GIT:=true}

: ${Z_PROMPT_WINTITLE:=true}
: ${Z_PROMPT_TABTITLE:=true}

export ${!Z_PROMPT_*}

# -----------------------------------------------------------------------------
# sanity checks for prompt features
# -----------------------------------------------------------------------------

# only change window title if supported by current terminal
if [[ ! $TERM =~ xterm|rxvt|putty|screen|cygwin ]]; then
    Z_PROMPT_WINTITLE=false
fi

# TODO: equivalent to above for tab title

# only use colours if supported by current terminal
if (( TERM_COLOURDEPTH < 8 )); then
    Z_PROMPT_COLOUR=false
fi

# Prompt (iOS SSH client)
if [[ $TERM_PROGRAM =~ ^Prompt ]]; then
    Z_PROMPT_WINTITLE=false
    : ${Z_PROMPT_TYPE:=basic}
fi

# Terminal.app has its own functions for this
if [[ $TERM_PROGRAM == Apple_Terminal ]]; then
    Z_PROMPT_WINTITLE=false
    Z_PROMPT_TABTITLE=false
fi

# -----------------------------------------------------------------------------
# functions
# -----------------------------------------------------------------------------

PS1_compress_pwd()
{ # Usage: PS1_compress_pwd "$PWD"

  # Trims leading elements of the current directory like so:
  #   ~/first/second/third/fourth
  #   ~/fi…/se…/third/fourth/fifth
  #   ~/fi…/se…/th…/fourth/fifth/sixth
  #   ~/fi…/se…/th…/fo…/fifth/sixth/seventh

  # Compress if PWD has __ or more elements (not counting `~`).
  local min_depth=5

  # Always retain the full names of the last __ elements.
  local keep_dirs=2

  # When compressing a directory element, keep the first __ characters.
  local keep_chars=2

  # Append __ to each trimmed element to indicate it has been compressed.
  local indicator="…"

  if [[ $Z_PROMPT_TYPE == basic ]]; then
    min_depth=1 # activate on any multi-part path
    keep_dirs=1 # only keep the last element
    keep_chars=1
  fi

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

  # Are there enough elements to warrant compression?
  if (( ${#input_parts[@]} >= ${min_depth} )); then

    # If PWD is under HOME, input_parts[0] will contain the leading tilde;
    # otherwise, it will be empty, and this command will print nothing.
    printf "%s" "${input_parts[0]}"

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

      # No need to compress elements that are already short.
      if (( ${#part} > ${keep_chars} )); then
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

PS1_print_exit()
{ # print non-zero exit codes on the far right of the screen (zsh envy...)
  local last_exit=$?
  local gutter=1
  local sigspec

  if (( last_exit != 0 )); then
    # abort if tput doesn't exist
    hash tput 2>/dev/null || return

    # if last command terminated from a signal, print that instead
    if (( last_exit > 128 )) && sigspec=$(builtin kill -l $last_exit 2>/dev/null); then
      last_exit=${sigspec#SIG}
    elif (( last_exit >= 64 && last_exit <= 78 )); then
      # someone's been reading /usr/include/sysexits.h ;)

      local exits=([64]="USAGE" [65]="DATAERR" [66]="NOINPUT" [67]="NOUSER"
        [68]="NOHOST" [69]="UNAVAILABLE" [70]="SOFTWARE" [71]="OSERR"
        [72]="OSFILE" [73]="CANTCREAT" [74]="IOERR" [75]="TEMPFAIL"
        [76]="PROTOCOL" [77]="NOPERM" [78]="CONFIG")
      last_exit=${exits[$last_exit]}
    fi

    local screen_width=${COLUMNS:-$(tput cols)}
    local padding=$(( screen_width - gutter ))

    # save cursor position
    tput sc

    # print exit code
    case $Z_PROMPT_TYPE in
      oneline)
        printf "%*s" $padding "$last_exit"
        ;;
      twoline|*)
        padding=$(( padding + ${#esc_false} + ${#esc_reset} ))

        printf "%*b" $padding "${esc_false}${last_exit}${esc_reset}"
        ;;
    esac

    # restore cursor position
    tput rc
  fi
}

PS1_git_info()
{
  local branch branches status
  local re='\* ([[:graph:]]+)'

  # get name of branch, or bail out if no branch exists
  branches=$(git branch --no-color 2>/dev/null) || return

  # parse name of branch
  if [[ $branches =~ $re ]]; then
    branch="${BASH_REMATCH[1]}"
  else
    return
  fi

  # $status = '*' if there's anything to commit
  if git status --porcelain 2>/dev/null | command grep -m1 -q '^.'; then
    status="${esc_false}*${esc_null}"
  fi

  if [[ $branch != master ]] || true; then
    printf " ${esc_2d}${branch}${esc_null}"
  fi

  printf "${status}"
}

# -----------------------------------------------------------------------------
# PROMPT_COMMAND
# -----------------------------------------------------------------------------

z::prompt::cmd_add()
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

z::prompt::cmd_del()
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
  # notify iTerm of the current directory
  if _isFunction iterm::state; then
    PS1_update_iTerm() { iterm::state; }
  else
    PS1_update_iTerm()
    {
      printf '%b%s%b' "${OSC}50;CurrentDir=${PWD}${BEL}"
    }
  fi

  z::prompt::cmd_add PS1_update_iTerm
fi

if [[ $TERM_PROGRAM == Apple_Terminal ]]; then
  # unset Apple's stock function
  unset -f update_terminal_cwd

  PS1_update_Terminal()
  { # Notify Terminal.app of the current directory
    # Format:   file://hostname/path/to/pwd
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

  z::prompt::cmd_add PS1_update_Terminal
fi

if [[ $Z_PROMPT_WINTITLE == true ]]; then
  z::prompt::cmd_add 'setwintitle "$USER@$HOSTNAME"'
fi

if [[ $Z_PROMPT_TABTITLE == true ]]; then
  if [[ $TERM_PROGRAM == iTerm.app ]]; then
    z::prompt::cmd_add 'settabtitle "${ITERM_SESSION_ID%:*}"'
  else
    z::prompt::cmd_add 'settabtitle "$USER@$HOSTNAME"'
  fi
fi

if _inPath direnv; then
  z::prompt::cmd_add -p '_direnv_hook'
fi

z::prompt::cmd_add -p 'history -a' # append to HISTFILE
### ZGM disabled -- I don't want sessions to share history...
# z::prompt::cmd_add -p 'history -n' # read from HISTFILE (so tmux windows can share history)

# -----------------------------------------------------------------------------
# colours
# -----------------------------------------------------------------------------

if [[ $Z_PROMPT_COLOUR == true ]]; then
  # root gets red prompt
  if (( EUID == 0 )); then
    esc_user=${esc_red}
  fi

  z::colour::PS1_esc()
  { # create new colour variables w/ prompt escape codes (\[ and \])

    local -a indexes=("$@")
    local index

    # $esc_green -> $PS1_green, $esc_true -> $PS1_true
    for index in "${indexes[@]}"; do
      local var_name="PS1_${index#*_}"

      if [[ -n ${!index} && -z ${!var_name} ]] || [[ $z_reloading == true ]]; then
        eval "$var_name=\"\[${!index}\]\""
      fi
    done
  }

  z::colour::PS1_esc ${!esc_*}
fi

# -----------------------------------------------------------------------------
# PS1 setup
# -----------------------------------------------------------------------------

# parts
unset -v z_PS1_{git,pwd,ssh,usr}

if [[ $Z_PROMPT_EXIT == true ]]; then
  z_PS1_exit="\[\$(PS1_print_exit)\]"

  if [[ $Z_PROMPT_TYPE != twoline ]]; then
    # `PS1_print_exit` doesn't print colour codes for other types of prompt
    z_PS1_exit="${PS1_false}${z_PS1_exit}${PS1_null}"
  fi
fi

if [[ -n $SSH_CONNECTION ]]; then
  # hostname
  z_PS1_ssh="\h"

  if [[ $Z_PROMPT_TYPE == twoline ]]; then
    # username and hostname
    z_PS1_ssh="\u@\h"
  fi

  z_PS1_ssh="${PS1_2d}${z_PS1_ssh}${PS1_null}"
fi

if [[ $Z_PROMPT_GIT == true ]]; then
  # info about current git branch, if any
  z_PS1_git="\$(PS1_git_info)"
fi

# current path, highlighted
z_PS1_pwd="${PS1_hi}\$(PS1_compress_pwd)"

# blue $ for me, red # for root
z_PS1_usr="${PS1_user}\\\$${PS1_null} "

# -----------------------------------------------------------------------------

# different kinds of prompt
declare -A z_PS1=()

# ----- two-line prompt -----

z_PS1[twoline]+="${z_PS1_exit}"
z_PS1[twoline]+="┌"

if [[ -n $z_PS1_ssh ]]; then
  z_PS1[twoline]+="─ ${z_PS1_ssh} "
fi

z_PS1[twoline]+="─┤ ${z_PS1_pwd}${z_PS1_git}${PS1_null}\n"
z_PS1[twoline]+="└ ${z_PS1_usr}"

# ----- one-line prompt -----

z_PS1[oneline]+="${z_PS1_exit}"

if [[ -n $z_PS1_ssh ]]; then
  z_PS1[oneline]+="${z_PS1_ssh}:"
fi

z_PS1[oneline]+="${z_PS1_pwd}${z_PS1_git} ${z_PS1_usr}"

# ----- basic prompt -----

z_PS1[basic]+="${z_PS1_exit}"

if [[ -n $z_PS1_ssh ]]; then
  z_PS1[basic]+="${z_PS1_ssh}:"
fi

z_PS1[basic]+="${z_PS1_pwd} ${z_PS1_usr}"

# ----- "no" prompt -----

z_PS1[off]="${z_PS1_usr}"

# -----------------------------------------------------------------------------
# PS1-4
# -----------------------------------------------------------------------------

PS1=${z_PS1[${Z_PROMPT_TYPE:-off}]}

# secondary prompt (for multi-line commands) -- bright white right guillemet
PS2="${PS1_hi}"$'\xC2\xBB'"${PS1_null} "

# `select` prompt -- blue question mark
PS3="${PS1_blue}?${PS1_null} "

# prefix for xtrace output
PS4='+ '
xse="${PS1_null}:" # separator

PS4+="\${BASH_SOURCE[0]+$PS1_2d\${BASH_SOURCE[0]}$xse$PS1_blue\$LINENO$xse}"
PS4+="\${FUNCNAME:+\${FUNCNAME[0]}()$xse}"
PS4+="\${BASH_COMMAND}\n\011"

# -----------------------------------------------------------------------------
# prompt manipulation
# -----------------------------------------------------------------------------

prompt()
{
  local types="${!z_PS1[*]}"

  case " $types " in
    *" $1 "*)
      export Z_PROMPT_TYPE=$1
      rl prompt >/dev/null
      ;;
    *)
      echo "Usage: ${FUNCNAME[0]} ${types// /|}"
      return
      ;;
  esac
}

# completion for prompt types
complete -W "${!z_PS1[*]}" prompt
