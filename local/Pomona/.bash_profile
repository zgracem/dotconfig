if [[ $- == *i* ]]; then
  # Launch fish (while keeping /bin/bash as login shell)
  SHELL=$XDG_BIN_HOME/fish
  [[ -x "$SHELL" ]] && exec "$SHELL" --login
else
  [[ -r $HOME/.bashrc ]] && . "$HOME/.bashrc"
fi
