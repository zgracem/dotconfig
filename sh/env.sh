#!/bin/sh
# -----------------------------------------------------------------------------
# ~/.config/sh/env.sh
# Environment variables for all POSIX shells
# -----------------------------------------------------------------------------

[ -n "$Z_ENV_SOURCED" ] && return

# XDG Basedir Spec
[ -f "$XDG_CONFIG_HOME/sh/xdg.sh" ] && . "$XDG_CONFIG_HOME/sh/xdg.sh"

# Set up PATH, MANPATH, etc.
# shellcheck source=sh/paths.sh
[ -f "$XDG_CONFIG_HOME/sh/paths.sh" ] && . "$XDG_CONFIG_HOME/sh/paths.sh"

# Make environment available to non-interactive bash shells
if [ -z "$BASH_ENV" ]; then
  export BASH_ENV="${ENV-$XDG_CONFIG_HOME/sh/env.sh}"
fi

# Fix missing environment variables
[ -z "$USER" ] && USER=$(whoami) && export USER
[ -z "$HOSTNAME" ] && HOSTNAME=$(uname -n) && export HOSTNAME
[ -z "$TMPDIR" ] && TMPDIR=$(dirname "$(mktemp -u)") && export TMPDIR

# Add domain to names of shared hosts
case $HOSTNAME in
  WS-*|web[[:digit:]]*|opal[[:digit:]]*)
    if full_hostname=$(hostname -f 2>/dev/null); then
      HOSTNAME=$full_hostname
    fi
    unset -v full_hostname
    ;;
esac

# If the current user's group doesn't own TMPDIR, check to see if it's mounted
# "noexec" (as it would be on a shared host) and change to a path we control.
if [ ! -G "$TMPDIR" ] && mount | grep -q " on $TMPDIR.*noexec,"; then
  TMPDIR="$HOME/var/run"
  [ -d "$TMPDIR" ] || mkdir -p "$TMPDIR"
fi

case $(uname -s) in
  *_NT-*) PLATFORM="windows" ;;
  Darwin) PLATFORM="mac" ;;
  Linux)  PLATFORM="linux" ;;
  *)      PLATFORM="unknown" ;;
esac
export PLATFORM

for env_file in "$XDG_CONFIG_HOME/env.d/"*.env "$XDG_CONFIG_HOME/sh/env.d/"*.sh; do
  [ -r "$env_file" ] && . "$env_file"
done

unset -v env_file

unset -v GIT_EDITOR SUDO_EDITOR

export Z_ENV_SOURCED=true
