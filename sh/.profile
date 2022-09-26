# -----------------------------------------------------------------------------
# ~/.config/sh/profile                                               ~/.profile
# executed by sh(1) for login shells
# -----------------------------------------------------------------------------

# Setup environment
export ENV=~/.config/sh/env.sh
# shellcheck source=.config/sh/env.sh
. "$ENV"

# -----------------------------------------------------------------------------
# Support functions
# -----------------------------------------------------------------------------

_inPath()
{ #: -- exits 0 if $1 is installed in $PATH
  type -P "$1" >/dev/null
  # command -v "$1" >/dev/null # ← returns true for functions, etc.

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
