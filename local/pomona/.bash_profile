if [[ $- == *i* ]]; then
  # Launch fish (while keeping /bin/bash as login shell)
  SHELL=$HOME/.local/bin/fish
  [[ -x "$SHELL" ]] && exec "$SHELL" --login
else
  [[ -r $HOME/.bashrc ]] && . "$HOME/.bashrc"
fi
