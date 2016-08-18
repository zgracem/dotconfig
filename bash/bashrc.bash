# -----------------------------------------------------------------------------
# ~/.config/bash/bashrc.bash                                          ~/.bashrc
# Executed by bash(1) for interactive shells
# -----------------------------------------------------------------------------

# Source ~/.profile
if [[ -r $HOME/.config/sh/profile.sh ]] ; then
  . "$HOME/.config/sh/profile.sh"
fi

# Abort if...
if ! test "$BASH_VERSINFO" || (( BASH_VERSINFO[0] < 3 )); then
  # ...bash is too old
  return
elif ! [[ -n $PS1 && $- =~ i ]]; then
  # ...this isn't an interactive shell
  return
elif shopt -q restricted_shell; then
  # ...this is a restricted shell
  return
fi

# Switch to bash-4.4 if available
latest_bash=44
this_bash="${BASH_VERSINFO[0]}${BASH_VERSINFO[1]}"

if (( this_bash < latest_bash )) && [[ -x $HOME/opt/bin/bash ]]; then
  export SHELL="$HOME/opt/bin/bash"

  # Temporarily export shell options so the new shell inherits them.
  export SHELLOPTS

  # Prevent shell from exiting if `exec` fails.
  shopt -s execfail

  if shopt -pq login_shell; then
    exec -l "$SHELL"
  else
    exec "$SHELL"
  fi
  shopt -u execfail
else
  # We don't actually want to *keep* them exported, though.
  declare +x SHELLOPTS
fi

# # redundant with the above? test on 4.4-final
# if [[ $BASH != $SHELL ]]; then
#   export SHELL=$BASH
# fi

# -----------------------------------------------------------------------------
# Shell options
# -----------------------------------------------------------------------------

set -o noclobber        # >file won't overwrite existing file (override with >|file)
set -o notify           # notify of job termination immediately (not on next prompt)
set -o pipefail         # pipelines return rightmost non-zero status, if any
set -o vi               # vi mode

shopt -s extglob        # enable extended pattern matching
shopt -s nocaseglob     # case-insensitive globbing (used in pathname expansion)
shopt -s nocasematch    # case-insensitive pattern matching in `case` and `[[`
shopt -u nullglob       # interferes with bash-completion

shopt -s checkwinsize   # update LINES & COLUMNS after each command if necessary
shopt -s gnu_errfmt     # print shell error messages in standard GNU format
shopt -u sourcepath     # [don't] use PATH to find files to source

# bash-4.0+ options
# -- http://wiki.bash-hackers.org/scripting/bashchanges#shell_options

if (( BASH_VERSINFO[0] >= 4 )); then
  if (( BASH_VERSINFO[1] >= 2 )); then
    shopt -s lastpipe   # execute a pipeline's last cmd in the current shell context
  fi

  if (( BASH_VERSINFO[1] >= 1 )); then
    # checkjobs is available but buggy in 4.0
    # -- https://lists.gnu.org/archive/html/bug-bash/2009-02/msg00176.html
    shopt -s checkjobs  # warn when exiting shell with stopped/running jobs
  fi

  if (( BASH_VERSINFO[1] >= 0 )); then
    shopt -s globstar   # '**' matches all directories and their files recursively
  fi
fi

# -----------------------------------------------------------------------------
# Miscellaneous settings
# -----------------------------------------------------------------------------

export USER=${USER:-$(id -un)}
export HOSTNAME=${HOSTNAME:-$(uname -n)}
export TMPDIR=${TMPDIR:-$(dirname "$(mktemp -ut tmp.XXX)")}

case $HOSTNAME in
  *.local)
    # trim domain ".local"
    HOSTNAME=$(hostname -s)
    ;;
  @(WS|web)+([[:digit:]])*)
    # add domain
    HOSTNAME=$(hostname -f) 
    ;;
esac

if [[ -z $HOME ]]; then
  # This happened to me once. Literally one time, ever. Then I wrote this.
  # You do not want to find yourself in a shell without HOME set.
  # *Everything* breaks. And since, if HOME is suddenly empty or unset,
  # that's probably not even the biggest problem, notify the user immediately.
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

export HOME

# Filesystem blocks of 1 KB, like the good Lord intended
export BLOCKSIZE=1024

# Abort runaway function nesting in bash-4.2+
FUNCNEST=128

# Require ^D × (n+1) to exit
IGNOREEOF=2

# End ssh sessions after 8 hours of inactivity
if [[ -n $SSH_CONNECTION && -z $STY && -z $TMUX ]]; then
  TMOUT=$(( 8 * 60 * 60 ))
fi

# Default 'rwXr-Xr-X' permissions for new files
umask 0022

# -----------------------------------------------------------------------------
# Terminals
# -----------------------------------------------------------------------------

# Control sequences
CSI=$'\e['  # Control Sequence Introducer
OSC=$'\e]'  # Operating System Command
DCS=$'\eP'  # Device Control String
 ST=$'\e\\' # String Terminator
BEL=$'\a'   # 🔔

# Just say no to flow control
(type -P stty && stty -ixon) &>/dev/null

# Custom terminfo files
TERMINFO="$HOME/share/terminfo"

if [[ -d $TERMINFO ]]; then
  export TERMINFO
  export TERMINFO_DIRS="$TERMINFO:/usr/local/opt/ncurses/share/terminfo:/usr/share/terminfo"

  TERMINFO_DIRS=$(fixpath "$TERMINFO_DIRS")

  # Darwin's full-screen system console
  if [[ $TERM == "vt100" && $OSTYPE =~ darwin && $(tty) == /dev/console ]]; then
    TERM=xnuppc
    export HV_DISABLE_PP=1
  fi

  # Old versions of Terminal.app
  if [[ $TERM_PROGRAM == "Apple_Terminal" && $TERM != nsterm* ]]; then
    ver=${TERM_PROGRAM_VERSION%%.*} # Major version (integer) only
    case 1 in
      $(( ver >= 361 ))*) # OSX 10.11
        TERM=nsterm-build361 ;;
      $(( ver >= 343 ))*) # OSX 10.10
        TERM=nsterm-build343 ;;
      $(( ver >= 326 ))*) # OSX 10.9
        TERM=nsterm-build326 ;;
      $(( ver >= 303 ))*) # OSX 10.7 & 10.8
        TERM=nsterm-256color ;;
      $(( ver >= 240 ))*) # OSX 10.5
        TERM=nsterm-16color ;;
      *)
        # This is probably god-awfully old; just leave it alone.
        : ;;
    esac
  
  # iTerm.app
  elif [[ $TERM_PROGRAM == "iTerm.app" && $TERM != "iTerm.app" ]]; then
    TERM="iTerm.app"
  fi
else
  unset -v TERMINFO
fi

# -----------------------------------------------------------------------------
# Other config files
# -----------------------------------------------------------------------------

export dir_config="$HOME/.config"

# For reasons I have yet (2016-06-29) to learn, xterm(1) sessions start with
# POSIXLY_CORRECT set to "y", which messes up a lot of my config files. This
# should detect when that's happening and disable it.
if [[ $POSIXLY_CORRECT == "y" && -n $XTERM_VERSION ]]; then
  unset -v POSIXLY_CORRECT
fi

# Call `rl -v` (see bashrc.d/config.bash) to troubleshoot slow shell startups.
# Each filename will appear as it is sourced; slowpokes will visibly linger.
if [[ $Z_RL_VERBOSE == true && $TIME_TEST_ACTIVE != true ]]; then
  .()
  {
    tput cr   # move cursor to beginning of line
    tput el   # clear to end of line
    # printf "\r${CSI}K%s" "$@"
    printf "%s" "$@"
    builtin . "$@"
  }
fi

export INPUTRC="$dir_config/inputrc"

# Define important shell functions
. "$dir_config/bash/functions.bash"

# Load direction definitions ($dir_foo)
. "$dir_config/bash/dirs.bash"

# Define colours (before ./bashrc.d/prompt.bash loads)
. "$dir_config/bash/colour.bash"

# Temporarily enable
shopt -s nullglob

# Private stuff
if [[ -d $dir_config/bash/private.d ]]; then
  for file in "$dir_config"/bash/private.d/*.bash; do
    [[ -f $file ]] && . "$file"
  done
fi

# Lesser function files
if [[ -d $dir_config/bash/functions.d ]]; then
  for file in "$dir_config"/bash/functions.d/*.bash; do
    [[ -f $file ]] && . "$file"
  done
fi

# Supplementary startup files
if [[ -d $dir_config/bash/bashrc.d ]]; then
  for file in "$dir_config"/bash/bashrc.d/*.bash; do
    [[ -f $file ]] && . "$file"
  done
fi

# Machine specific files in ~/.local
if [[ -d $dir_local/config/bashrc.d ]]; then
  for file in "$dir_local"/config/bashrc.d/*.bash; do
    [[ -f $file ]] && . "$file"
  done
fi

# Disable after temporarily enabling above
shopt -u nullglob

unset -v file

# -----------------------------------------------------------------------------
# And finally...
# -----------------------------------------------------------------------------

# Set window title (environment variable set in bashrc.d/prompt.bash)
if [[ -n $Z_SET_WINTITLE ]]; then
  setwintitle "$USER@$HOSTNAME"
fi

# Final initialization scripts, except in subshells/when reloading/as root
if (( SHLVL <= 1 )) \
  && (( BASH_SUBSHELL < 1 )) \
  && [[ -z $Z_NO_INIT ]] && [[ -z $Z_RELOADING ]] \
  && (( EUID != 0 ))
then
  . "$dir_config/bash/init.bash"

  if [[ -f $dir_local/config/init.bash ]]; then
    . "$dir_local/config/init.bash"
  fi
fi

# Cleanup after debugging
if _isFunction .; then
  tput cr   # move cursor to beginning of line
  tput el   # clear to end of line
  unset -f .
fi
