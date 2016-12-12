if _inPath stow; then
  stow() { command stow --verbose "$@"; }
fi
