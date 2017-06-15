if _inPath stow; then
  stow() { command stow --verbose "$@"; }
  unstow() { command stow --delete "$@"; }
fi
