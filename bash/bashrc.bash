# -----------------------------------------------------------------------------
# ~/.bashrc
# Executed by bash(1) on interactive shell startup
# -----------------------------------------------------------------------------

# Source ~/.profile
if [[ -r $HOME/.config/sh/profile.sh ]] ; then
  . "$HOME/.config/sh/profile.sh"
fi

# Abort if...
if ! test "$BASH_VERSINFO" || (( BASH_VERSINFO[0] < 3 )); then
  # ...bash is too old
  echo >&2 "this version of bash is too old!"
  return
elif ! [[ $- == *i* ]]; then
  # ...this isn't an interactive shell
  return
elif shopt -q restricted_shell; then
  echo >&2 "restricted shell -- aborting .bashrc"
  return
else
  export Z_IN_BASHRC=true
fi

# -----------------------------------------------------------------------------
# Shell options
# -----------------------------------------------------------------------------

set -o noclobber        # >file won't overwrite (use >|file for that)
set -o notify           # done jobs notify immediately, not on next prompt
set -o pipefail         # pipelines return rightmost non-zero status, if any
set -o vi               # vi mode

shopt -s extglob        # enable extended pattern matching
shopt -s nocaseglob     # case-insensitive globbing in pathn?m* expansion
shopt -s nocasematch    # case-insensitive patterns in `case` and `[[`
shopt -u nullglob       # (interferes with bash-completion)

shopt -s checkwinsize   # update LINES & COLUMNS after each command
shopt -s gnu_errfmt     # print shell error messages in standard GNU format
shopt -u sourcepath     # [don't] use PATH to find files to `.`

# bash-4.0+ options
# >> http://wiki.bash-hackers.org/scripting/bashchanges#shell_options

if (( BASH_VERSINFO[0] >= 4 )); then
  if (( BASH_VERSINFO[1] >= 2 )); then
    # Execute a pipeline's last cmd in the current shell context
    shopt -s lastpipe
    # Abort runaway function nesting
    FUNCNEST=128
  fi

  if (( BASH_VERSINFO[1] >= 1 )); then
    # Warn when exiting shell with stopped/running jobs
    shopt -s checkjobs 
    # `checkjobs` is available in 4.0, but buggy:
    # >> https://lists.gnu.org/archive/html/bug-bash/2009-02/msg00176.html
  fi

  if (( BASH_VERSINFO[1] >= 0 )); then
    # `**` matches directories and their files recursively
    shopt -s globstar
  fi
fi

# Require ^D × (n+1) to exit
IGNOREEOF=2

# Kill ssh sessions after 8 hours' inactivity, unless tmux/screen is active
if [[ -n $SSH_CONNECTION && -z $TMUX && -z $STY ]]; then
  TMOUT=$(( 8 * 60 * 60 ))
fi

# -----------------------------------------------------------------------------
# Switch to bash-4.4 if available
# -----------------------------------------------------------------------------

latest_bash=44
this_bash="${BASH_VERSINFO[0]}${BASH_VERSINFO[1]}"

if (( this_bash < latest_bash )); then
  unset -v newer_bash
  case $HOSTNAME in
    WS*)
      # If I launch Cygwin with anything besides /bin/bash, the session crashes
      # immediately. I don't know why. -- ZGM 2016-09-16
      newer_bash=/usr/local/bin/bash
      ;;
    web*)
      # I'm obviously not allowed to change anything on my shared host.
      newer_bash="$HOME/.linuxbrew/bin/bash"
      ;;
    *)
      # If present, probably newer than the default.
      newer_bash="$HOME/opt/bin/bash"
      ;;
  esac

  if [[ -x $newer_bash && $newer_bash != $SHELL ]]; then
    export SHELL="$newer_bash"

    ### ZGM 2016-11-22 -- Why?
    # # Temporarily export shell options so the new shell inherits them.
    # export SHELLOPTS 2>/dev/null

    # Prevent shell from exiting if `exec` fails.
    shopt -s execfail

    if shopt -pq login_shell; then
      exec -l "$SHELL"
    else
      exec "$SHELL"
    fi
  else
    unset -v newer_bash
  fi  
fi

# We don't actually want to *keep* those settings, though.
shopt -u execfail
# declare +x SHELLOPTS 2>/dev/null

# -----------------------------------------------------------------------------
# Essential environment variables
# -----------------------------------------------------------------------------

if [[ -z $HOME ]]; then
  # This happened to me once. Ever. Then I wrote this. *Everything* breaks if
  # HOME is suddenly empty or unset, and if that's the case, it's probably not
  # even the biggest problem, so notify the user immediately.
  printf "HOME not found, searching... " >&2

  # First, the simplest: grep the system passwd(5) file and take the homedir
  # from the sixth (`-f6`) colon-delimited (`-d:`) field. If grep fails,
  # it will pass the false exit status through (because `pipefail` is set)
  # and try to query Directory Services; if that fails, Python will try to
  # resolve it.
  HOME=$(grep "^$USER" /etc/passwd | cut -f6 -d:) \
  || HOME=$(dscl . -read /Users/$USER NFSHomeDirectory 2>/dev/null | cut -d' ' -f2) \
  || HOME=$(python -c 'import os;print os.path.expanduser("~")' 2>/dev/null) \
  || {
    # ...but if Python can't, then I'm out of ideas, so we'd better abort
    # before things get even worse.
    printf 'failed!\n' >&2; return 1;
  }

  printf '%s\n' "$HOME"
fi

# -----------------------------------------------------------------------------
# Other config files
# -----------------------------------------------------------------------------

export dir_config="${XDG_CONFIG_HOME:-$HOME/.config}"

# Call `rl -v` (see bashrc.d/config.bash) to troubleshoot slow shell startups.
# Each filename will appear as it is sourced; slowpokes will visibly linger.
if [[ -n $Z_RL_VERBOSE && $TIME_TEST_ACTIVE != true ]]; then
  .()
  {
    printf $'\r'    # (tput cr) move cursor to beginning of line
    printf $'\e[K'  # (tput el) clear to end of line

    local f; for f in "$@"; do
      printf "%s" "${f/#$HOME/$'~'}"
      builtin . "$f"
    done
  }
fi

export INPUTRC="$dir_config/inputrc"

# Define important shell functions
. "$dir_config/bash/_functions.bash"

# Terminal-related setup
. "$dir_config/bash/_terminal.bash"

# Load direction definitions ($dir_foo)
. "$dir_config/bash/_dirs.bash"

# Define colours (before _prompt.bash loads)
. "$dir_config/bash/_colour.bash"

# Set fancy prompt
. "$dir_config/bash/_prompt.bash"

# Temporarily enable
shopt -s nullglob

# Private stuff
for file in "$dir_config"/bash/private.d/*.bash; do
  [[ -f $file ]] && . "$file"
done

# Lesser function files
for file in "$dir_config"/bash/functions.d/*.bash; do
  [[ -f $file ]] && . "$file"
done

# Supplementary startup files
for file in "$dir_config"/bash/bashrc.d/*.bash; do
  [[ -f $file ]] && . "$file"
done

# Machine specific files in ~/.local
if [[ -d ~/.local/config/bashrc.d ]]; then
  for file in ~/.local/config/bashrc.d/*.bash; do
    [[ -f $file ]] && . "$file"
  done
fi

# Disable after temporarily enabling above
shopt -u nullglob

# -----------------------------------------------------------------------------
# And finally...
# -----------------------------------------------------------------------------

# Final initialization scripts, except in subshells/when reloading/as root
if   (( SHLVL <= 1 )) \
  && (( BASH_SUBSHELL < 1 )) \
  && [[ -z $Z_RELOADING ]] \
  && [[ -z $Z_NO_INIT ]] \
  && (( EUID != 0 ))
then
  . "$dir_config/bash/init.bash"

  if [[ -f ~/.local/config/init.bash ]]; then
    . ~/.local/config/init.bash
  fi
fi

# Clean up
if _isFunction .; then
  tput cr   # move cursor to beginning of line
  tput el   # clear to end of line
  unset -f .
fi

unset -v file latest_bash this_bash newer_bash
unset -v Z_IN_BASHRC
