# -----------------------------------------------------------------------------
# ~/.config/sh/profile                                               ~/.profile
# executed by sh(1) for login shells
# -----------------------------------------------------------------------------

# Default 'rwXr-Xr-X' permissions for new files
umask 0022

# Filesystem blocks of 1 KB, like the good lord intended
export BLOCKSIZE=1024

# XDG Basedir Spec
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/share"
export XDG_CACHE_HOME="$HOME/var/cache"

export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

# Set up PATH, MANPATH, etc.
if [ -r "$XDG_CONFIG_HOME/sh/paths.sh" ]; then
  . "$XDG_CONFIG_HOME/sh/paths.sh"
fi

# Fix missing environment variables
[ -z "$USER" ] && export USER=$(whoami)
[ -z "$HOSTNAME" ] && export HOSTNAME=$(uname -n)
[ -z "$TMPDIR" ] && export TMPDIR=$(dirname "$(mktemp -u)")

# Add domain to names of shared hosts
case $HOSTNAME in
  WS[[:digit:]]*|web[[:digit:]]*)
    HOSTNAME=$(hostname -f)
    ;;
esac

# If the current user's group doesn't own TMPDIR, check to see if it's mounted
# "noexec" (as it would be on a shared host) and change to a path we control.
if [ ! -G $TMPDIR ] && mount|grep -q " on $TMPDIR.*noexec,"; then
  TMPDIR="$HOME/var/tmp"
fi

# -----------------------------------------------------------------------------
# Keep homedir tidy.
# -----------------------------------------------------------------------------

z_tidy()
{ # Usage: tidy ~/.bash_sessions
  local rm_opts="-f"

  if [[ $- == *i* ]]; then
    # interactive shell, be verbose
    rm_opts+="v"
  fi

  local targets=("$@")
  local target; for target in "${targets[@]}"; do
    if [ ! -e $target ]; then
      continue
    elif [ -d $target ]; then
      rm_opts+="r"
    fi

    command rm $rm_opts "$target" || return
  done
}

# -----------------------------------------------------------------------------
# Supplementary startup files
# -----------------------------------------------------------------------------

if [ -d "$XDG_CONFIG_HOME/sh/profile.d" ]; then
  for file in "$XDG_CONFIG_HOME/sh/profile.d/"*.sh; do
    [ -r "$file" ] && . "$file"
  done
fi

unset -v file
