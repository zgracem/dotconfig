# -----------------------------------------------------------------------------
# ~/.config/bash/bashrc.bash                                          ~/.bashrc
# executed by bash(1) for interactive shells
# -----------------------------------------------------------------------------

# source .profile
if [[ -r $HOME/.config/sh/profile.sh ]] ; then
  . "$HOME/.config/sh/profile.sh"
fi

# abort if...
if ! test "$BASH_VERSINFO" || (( BASH_VERSINFO[0] < 3 )); then
  # bash is too old
  return
elif ! [[ -n $PS1 && $- =~ i ]]; then
  # this isn't an interactive shell
  return
elif shopt -q restricted_shell; then
  # this is a restricted shell
  return
fi

# switch to bash-4.4 if available
if [[ -x $HOME/opt/bin/bash ]]; then
  export SHELL="$HOME/opt/bin/bash"
  if (( ${BASH_VERSINFO[0]}${BASH_VERSINFO[1]} < 44 )); then
    export SHELLOPTS
    exec -l "$SHELL"
  else
    BASH=$SHELL
  fi
fi

### ZGM disabled 2015-11-09 -- redundant with the above? test on 4.4-final
# if [[ $BASH != $SHELL ]]; then
#   export SHELL=$BASH
# fi

# -----------------------------------------------------------------------------
# shell options
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

# bash 4+ options
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
# miscellaneous settings
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

# filesystem blocks of 1KB, like the good lord intended
export BLOCKSIZE=1024

# abort runaway function nesting
FUNCNEST=128

# require ^D × (n+1) to exit
IGNOREEOF=2

# end ssh sessions after 8 hours of inactivity
if [[ -n $SSH_CONNECTION && -z $STY && -z $TMUX ]]; then
  TMOUT=$(( 8 * 60 * 60 ))
fi

# default 'rwXr-Xr-X' permissions for new files
umask 0022

# -----------------------------------------------------------------------------
# terminals
# -----------------------------------------------------------------------------

# control sequences
CSI=$'\e['  # Control Sequence Introducer
OSC=$'\e]'  # Operating System Command
DCS=$'\eP'  # Device Control String
 ST=$'\e\\' # String Terminator
BEL=$'\a'   # 🔔

# just say no to flow control
(type -P stty && stty -ixon) &>/dev/null

# fix screen's stupid broken $TERMCAP -- http://robmeerman.co.uk/unix/256colours
if [[ $TERM =~ screen-256color && -n $TERMCAP ]]; then
  TERMCAP=${TERMCAP/Co#8/Co#256}
fi

### ZGM disabled 2016-06-16
### -- don't have this, don't need this; and anyway, per terminfo(5),
###    if TERMINFO is set, ncurses won't look anywhere else for files.
# # custom terminfo
# if [[ -d $HOME/.terminfo ]]; then
#   export TERMINFO="$HOME/.terminfo"
# fi

# -----------------------------------------------------------------------------
# other config files
# -----------------------------------------------------------------------------

# Our remaining files do *not* conform to POSIX, so we shouldn't even try.
if [[ -n $POSIXLY_CORRECT ]]; then
  return
fi

# Call `rl -v` (see bashrc.d/config.bash) to troubleshoot slow shell startups.
# Each filename will appear as it is sourced; slowpokes will visibly linger.
# (See also related code in bashrc.d/keychain.bash when enabling/disabling.)

if [[ $Z_RL_VERBOSE == true && $TIME_TEST_ACTIVE != true ]]; then
  .()
  {
    printf "\r\e[K%s" "$1"
    builtin . "$@"
  }
fi

export dir_config="$HOME/.config"

export INPUTRC="$dir_config/inputrc"

# define important shell functions
. "$dir_config/bash/functions.bash"

if [[ $TIME_TEST_ACTIVE == true ]]; then
  if (( ${BASH_VERSINFO[0]}${BASH_VERSINFO[1]} >= 42 )); then
    printf -v TIME_TEST_LOG "$HOME/var/log/timetest_%(%y%m%d_%H%M%S)T.log" -1
  else
    TIME_TEST_LOG="$HOME/var/log/timetest_$(date +%y%m%d_%H%M%S).log"
  fi
  
  unset -f .

  .()
  {
    local TIMEFORMAT='%R' # seconds only
    local filename=$1
    local elapsed

    # stdout and stderr intact
    exec 3>&1 4>&2

    elapsed=$( { time source "$filename" 1>&3 2>&4; } 2>&1 )

    # restore fd's
    exec 3>&- 4>&-

    printf "%s\t%s\n" "$elapsed" "$filename" >> "$TIME_TEST_LOG"
  }
fi

# temporarily enable
shopt -s nullglob

# load direction definitions ($dir_foo)
. "$dir_config/bash/dirs.bash"

# define colours (before ./bashrc.d/prompt.bash loads)
. "$dir_config/bash/colour.bash"

# programmable completion
. "$dir_config/bash/completion.bash"

# private stuff
if [[ -d $dir_config/bash/private.d ]]; then
  for file in "$dir_config"/bash/private.d/*.bash; do
    [[ -f $file ]] && . "$file"
  done
fi

### ZGM moved above bashrc.d block 2016-06-15 -- see if this breaks anything
# lesser function files
if [[ -d $dir_config/bash/functions.d ]]; then
  for file in "$dir_config"/bash/functions.d/*.bash; do
    [[ -f $file ]] && . "$file"
  done
fi

# supplementary startup files
if [[ -d $dir_config/bash/bashrc.d ]]; then
  for file in "$dir_config"/bash/bashrc.d/*.bash; do
    [[ -f $file ]] && . "$file"
  done
fi

# machine specific files in ~/.local
if [[ -d $dir_local/config/bashrc.d ]]; then
  for file in "$dir_local"/config/bashrc.d/*.bash; do
    [[ -f $file ]] && . "$file"
  done
fi

# disable after temporarily enabling above
shopt -u nullglob

unset -v file

# -----------------------------------------------------------------------------
# and finally...
# -----------------------------------------------------------------------------

# set window title
if [[ $TERM =~ xterm|rxvt|putty|screen|cygwin ]] \
  && [[ $TERM_PROGRAM != Apple_Terminal ]] \
  && _isFunction setwintitle
then
  setwintitle "$USER@$HOSTNAME"
fi

# # enable preexec and precmd hooks
# if [[ -r $HOME/Dropbox/src/z-preexec.bash ]]; then
#     . "$HOME/Dropbox/src/z-preexec.bash"
#     # preexec() { echo ">> “$@”"; }
#     # precmd() { echo ">> printing the prompt..."; }
# fi

# final initialization scripts (except in subshells/when reloading)
if (( SHLVL <= 1 )) && (( BASH_SUBSHELL < 1 )) && [[ -z $Z_RELOADING ]]; then
  . "$dir_config/bash/init.bash"
  [[ -f $dir_local/config/init.bash ]] && . "$dir_local/config/init.bash"
fi

# -----------------------------------------------------------------------------
# cleanup after debugging
# -----------------------------------------------------------------------------

if [[ $TIME_TEST_ACTIVE == true ]]; then
  printf "%s\n" "$TIME_TEST_LOG"
  unset -v TIME_TEST_ACTIVE TIME_TEST_LOG
fi

if _isFunction .; then
  printf "\r\e[K"
  unset -f .
fi
