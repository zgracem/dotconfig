if command -v stow >/dev/null; then
  stow()
  {
    command stow --verbose "$@"
  }
  unstow()
  {
    command stow --delete "$@"
  }
fi
