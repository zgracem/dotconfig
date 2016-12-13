# -----------------------------------------------------------------------------
# ~/.config/sh/profile                                               ~/.profile
# executed by sh(1) for login shells
# -----------------------------------------------------------------------------

# Setup environment
export ENV=~/.config/environment.sh
. "$ENV"

# -----------------------------------------------------------------------------
# Support functions
# -----------------------------------------------------------------------------

# exits 0 if $1 is installed in $PATH
_inPath() { command -v "$1" >/dev/null; }

# exits 0 if $1 uses GNU switches
_isGNU() { command "$1" --version >/dev/null 2>&1; }

# -----------------------------------------------------------------------------

# Source supplementary startup files
for file in ~/.config/sh/profile.d/*; do
  [ -r "$file" ] && . "$file"
  unset -v file
done
