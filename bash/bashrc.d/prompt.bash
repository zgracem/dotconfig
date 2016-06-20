# -----------------------------------------------------------------------------
# ~/.config/bash/bashrc.d/prompt.bash
# -----------------------------------------------------------------------------
# setup
# -----------------------------------------------------------------------------

# prompt strings undergo parameter expansion and command substitution
shopt -s promptvars

# clear prompt-related variables so we can start fresh
unset -v PS{0..4}
unset -v PROMPT_COMMAND
unset -v PROMPT_DIRTRIM

# -----------------------------------------------------------------------------
# configuration
# -----------------------------------------------------------------------------

: ${Z_PROMPT_TYPE:=oneline}

: ${Z_PROMPT_COLOUR:=true}
: ${Z_PROMPT_EXIT:=true}
: ${Z_PROMPT_GIT:=false}

: ${Z_PROMPT_WINTITLE:=true}
: ${Z_PROMPT_TABTITLE:=true}

export ${!Z_PROMPT_*}

# -----------------------------------------------------------------------------
# sanity checks for prompt features
# -----------------------------------------------------------------------------

# only change window title if supported by current terminal
if [[ ! $TERM =~ xterm|rxvt|putty|screen|cygwin ]]; then
    Z_PROMPT_WINTITLE=false
    Z_PROMPT_TABTITLE=false
fi

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

z::prompt::compress_pwd()
{ # Usage: z::prompt::compress_pwd "$PWD"

  # Trims leading elements of the current directory like so:
  #   ~/first/second/3rd/fourth
  #   ~/fir…/sec…/3rd/fourth/fifth
  #   ~/fir…/sec…/3rd/fourth/fifth/sixth
  #   ~/fir…/sec…/3rd/fou…/fifth/sixth/seventh

  # Compress if PWD has __ or more elements (not counting `~`).
  local min_depth=4

  # Always retain the full names of the last __ elements.
  local keep_dirs=2

  # When compressing a directory element, keep the first __ characters.
  local keep_chars=3

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

z::prompt::print_exit()
{ # print non-zero exit codes on the far right of the screen (zsh envy...)
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
      # someone's been reading `/usr/include/sysexits.h`... ;)

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

z::prompt::git_info()
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
  #   "${esc_2d}${branch}" \
  #   "${icons:-}${esc_reset}"

  printf "${esc_reset} %b${esc_reset}" \
    "${esc_2d}${branch}${icons}"
}

# notify iTerm of the current directory
if _isFunction iterm::state; then
  z::prompt::update_iTerm() { iterm::state; }
else
  z::prompt::update_iTerm()
  {
    printf '%b%s%b' "${OSC}50;CurrentDir=${PWD}${BEL}"
  }
fi

# Notify Terminal.app of the current directory
z::prompt::update_Terminal()
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

z::prompt::update_titles()
{
  local tab_title="${USER}@${HOSTNAME%%.*}"
  local win_title="${tab_title}: ${PWD/#$HOME/$'~'}"

  if [[ $TERM_PROGRAM == iTerm.app ]]; then
    tab_title="${ITERM_SESSION_ID%:*}"
  fi

  [[ $Z_PROMPT_WINTITLE == true ]] && setwintitle "$win_title"
  [[ $Z_PROMPT_TABTITLE == true ]] && settabtitle "$tab_title"
}

# -----------------------------------------------------------------------------
# colours
# -----------------------------------------------------------------------------

if [[ $Z_PROMPT_COLOUR == true ]]; then
  # root gets red prompt
  if (( EUID == 0 )); then
    esc_user=${esc_red}
  fi

  # users in Administrators group get a red prompt too
  if [[ $OSTYPE == cygwin ]]; then
    for g in $(id -G); do
      if [[ $g == 544 ]]; then
        esc_user=${esc_red}
        break
      fi
    done
    unset g
  fi

  if [[ $HOSTNAME == Hiroko && $TERM_PROGRAM_VERSION == 240.2 ]]; then
    # we're running in Terminal.app locally
    esc_user=${esc_magenta}
  fi

  z::colour::PS1_esc()
  { # create new colour variables w/ prompt escape codes (\[ and \])

    local -a indexes=("$@")
    local index

    # $esc_green -> $PS1_green, $esc_true -> $PS1_true
    for index in "${indexes[@]}"; do
      local var_name="PS1_${index#*_}"

      if [[ -n ${!index} && -z ${!var_name} ]] || [[ $Z_RELOADING == true ]]; then
        printf -v $var_name "\[${!index}\]"
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
  z_PS1_exit="\[\$(z::prompt::print_exit)\]"

  if [[ $Z_PROMPT_TYPE != twoline ]]; then
    # `z::prompt::print_exit` doesn't print colour codes for other types of prompt
    z_PS1_exit="${PS1_false}${z_PS1_exit}${PS1_reset}"
  fi
fi

if [[ -n $SSH_CONNECTION ]]; then
  # hostname
  z_PS1_ssh="\h"

  if [[ $Z_PROMPT_TYPE == twoline ]]; then
    # username and hostname
    z_PS1_ssh="\u@\h"
  fi

  z_PS1_ssh="${PS1_2d}${z_PS1_ssh}${PS1_reset}"
fi

# info about current git branch, if any
z_PS1_git="\$(z::prompt::git_info)"

# current path, highlighted
z_PS1_pwd="${PS1_hi}\$(z::prompt::compress_pwd)"

# blue $ for me, red # for root
z_PS1_usr="${PS1_user}\\\$${PS1_reset} "

# -----------------------------------------------------------------------------

# different kinds of prompt
declare -A z_PS1=()

# ----- two-line prompt -----

z_PS1[twoline]+="${z_PS1_exit}"
z_PS1[twoline]+="┌"

if [[ -n $z_PS1_ssh ]]; then
  z_PS1[twoline]+="─ ${z_PS1_ssh} "
fi

z_PS1[twoline]+="─┤ ${z_PS1_pwd}${z_PS1_git}${PS1_reset}\n"
z_PS1[twoline]+="└ ${z_PS1_usr}"

# ----- one-line prompt -----

z_PS1[oneline]+="${z_PS1_exit}"

if [[ -n $z_PS1_ssh ]]; then
  z_PS1[oneline]+="${z_PS1_ssh}:"
fi

z_PS1[oneline]+="${z_PS1_pwd}${z_PS1_git} ${z_PS1_usr}"

# ----- basic prompt -----

z_PS1[basic]+="${z_PS1_exit}"

### ZGM removed 2016-03-30 -- not very "basic", is it...
# if [[ -n $z_PS1_ssh ]]; then
#   z_PS1[basic]+="${z_PS1_ssh}:"
# fi

z_PS1[basic]+="${z_PS1_pwd} ${z_PS1_usr}"

# ----- "no" prompt -----

z_PS1[off]="${z_PS1_usr}"

# -----------------------------------------------------------------------------
# PS1-4
# -----------------------------------------------------------------------------

PS1=${z_PS1[${Z_PROMPT_TYPE:-off}]}

# secondary prompt (for multi-line commands) -- bright white right guillemet
PS2="${PS1_hi}"$'\xC2\xBB'"${PS1_reset} "

# `select` prompt -- blue question mark
PS3="${PS1_blue}?${PS1_reset} "

# prefix for xtrace output
PS4='+ '
xse="${PS1_reset}:" # separator

PS4+="\${BASH_SOURCE[0]+$PS1_2d\${BASH_SOURCE[0]}$xse$PS1_blue\$LINENO$xse}"
PS4+="\${FUNCNAME:+\${FUNCNAME[0]}()$xse}"
PS4+="\${BASH_COMMAND}\n\011"

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
  z::prompt::cmd_add z::prompt::update_iTerm
else
  unset -f z::prompt::update_iTerm
fi

if [[ $TERM_PROGRAM == Apple_Terminal ]]; then
  z::prompt::cmd_add z::prompt::update_Terminal

  # unset Apple's stock function
  unset -f update_terminal_cwd
else
  unset -f z::prompt::update_Terminal
fi

if [[ $Z_PROMPT_WINTITLE == true || $Z_PROMPT_TABTITLE == true ]]; then
  z::prompt::cmd_add "z::prompt::update_titles"
  [[ $Z_PROMPT_WINTITLE == true ]] && PS0+="\$(setwintitle \"\u@\h: \w\")"
  [[ $Z_PROMPT_TABTITLE == true ]] && PS0+="\$(settabtitle \"\u@\h\")"
fi

z::prompt::cmd_add -p 'history -a'    # append to HISTFILE

# # if you want tmux sessions to share history:
# z::prompt::cmd_add -p 'history -n'  # read from HISTFILE

# see also bashrc.d/direnv.bash
if _isFunction _direnv_hook; then
  z::prompt::cmd_add -p '_direnv_hook'
fi

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

# -----------------------------------------------------------------------------
# cleanup
# -----------------------------------------------------------------------------

unset -f z::colour::PS1_esc z::prompt::cmd_{add,del}
unset -v ${!PS1_*}
