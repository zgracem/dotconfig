# -----------------------------------------------------------------------------
# ~/.config/sh/profile                                               ~/.profile
# executed by sh(1) for login shells
# -----------------------------------------------------------------------------

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/share"
export XDG_CACHE_HOME="$HOME/var/cache"

if [ -r "$XDG_CONFIG_HOME/sh/paths.sh" ]; then
  . "$XDG_CONFIG_HOME/sh/paths.sh"
fi

if [ -d "$XDG_CONFIG_HOME/sh/profile.d" ]; then
  for file in "$XDG_CONFIG_HOME/sh/profile.d/"*.sh; do
    [ -r "$file" ] && . "$file"
    unset file
  done
fi
