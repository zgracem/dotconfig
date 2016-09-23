# -----------------------------------------------------------------------------
# ~/.config/sh/profile                                               ~/.profile
# executed by sh(1) for login shells
# -----------------------------------------------------------------------------

if [ -r "$HOME/.config/sh/paths.sh" ]; then
  . "$HOME/.config/sh/paths.sh"
fi

if [ -d "$HOME/.config/sh/profile.d" ]; then
  for file in "$HOME/.config/sh/profile.d/"*.sh; do
    if [ -r "$file" ]; then
      . "$file"
    fi
    unset file
  done
fi
