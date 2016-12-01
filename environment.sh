# -----------------------------------------------------------------------------
# ~/.config/environment.sh
# Environment variables for all POSIX shells
# -----------------------------------------------------------------------------

# XDG Basedir Spec
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/var/cache"
export XDG_RUNTIME_DIR="$HOME/var/run"

# Location of zsh config files
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

# Make environment available to non-interactive bash shells
if [ -z "$BASH_ENV" ]; then
  export BASH_ENV="${ENV-$XDG_CONFIG_HOME/.config/environment.sh}"
fi

# Set up PATH, MANPATH, etc.
. "$XDG_CONFIG_HOME/sh/paths.sh"

# Fix missing environment variables
[ -z "$USER" ] && export USER=$(whoami)
[ -z "$HOSTNAME" ] && export HOSTNAME=$(uname -n)
[ -z "$TMPDIR" ] && export TMPDIR=$(dirname "$(mktemp -u)")

# Add domain to names of shared hosts
case $HOSTNAME in
  WS[[:digit:]]*|web[[:digit:]]*)
    if FULL_HOSTNAME=$(hostname -f 2>/dev/null); then
      HOSTNAME=$FULL_HOSTNAME
    fi
    unset -v FULL_HOSTNAME
    ;;
esac

# If the current user's group doesn't own TMPDIR, check to see if it's mounted
# "noexec" (as it would be on a shared host) and change to a path we control.
if [ ! -G $TMPDIR ] && mount|grep -q " on $TMPDIR.*noexec,"; then
  TMPDIR="$XDG_RUNTIME_DIR"
  [ -d "$TMPDIR" ] || mkdir -p "$TMPDIR"
fi

case $(uname -s) in
  *_NT-*) PLATFORM="windows" ;;
  Darwin) PLATFORM="mac" ;;
  Linux)  PLATFORM="linux" ;;
  *)      PLATFORM="unknown" ;;
esac
export PLATFORM

for env_file in "$XDG_CONFIG_HOME/environment.d/"*.sh; do
  [ -r "$env_file" ] && . "$env_file"
done

unset -v env_file
