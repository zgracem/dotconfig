# -----------------------------------------------------------------------------
# ~/.config/sh/profile                                               ~/.profile
# executed by sh(1) for login shells
# -----------------------------------------------------------------------------

# Setup environment
export ENV=~/.config/sh/env.sh
# shellcheck source=./env.sh
. "$ENV"

# Support function
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

# Source ~/.bashrc, unless it's sourcing this file
if [[ -z "$Z_IN_BASHRC" ]]; then
  export Z_IN_PROFILE=true
  [[ -r $HOME/.bashrc ]] && . $HOME/.bashrc
  unset -v Z_IN_PROFILE
fi
