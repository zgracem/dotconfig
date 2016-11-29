# -----------------------------------------------------------------------------
# ~/.config/sh/profile                                               ~/.profile
# executed by sh(1) for login shells
# -----------------------------------------------------------------------------

# Setup environment
. ~/.config/environment.sh

# Source supplementary startup files
for file in ~/.config/sh/profile.d/*.sh; do
  [ -r "$file" ] && . "$file"
done

unset -v file
