# -----------------------------------------------------------------------------
# ~/.config/sh/profile                                               ~/.profile
# executed by sh(1) for login shells
# -----------------------------------------------------------------------------

# Setup environment
export ENV=~/.config/environment.sh
. "$ENV"

# Source supplementary startup files
for file in ~/.config/sh/profile.d/*; do
  [ -r "$file" ] && . "$file"
done

unset -v file
