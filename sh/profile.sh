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

_inPath()
{ #: -- exits 0 if $1 is installed in $PATH
  command -v "$1" >/dev/null
}

_isGNU()
{ #: -- exits 0 if $1 uses GNU switches
  command "$1" --version >/dev/null 2>&1
}

# -----------------------------------------------------------------------------

# Source supplementary startup files
for file in ~/.config/sh/profile.d/*; do
  [ -r "$file" ] && . "$file"
  unset -v file
done
