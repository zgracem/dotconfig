if [[ $- == *i* ]]; then
  # Launch fish (while keeping /bin/bash as login shell)
  HOMEBREW_PREFIX=/home/linuxbrew/.linuxbrew
  SHELL=$HOMEBREW_PREFIX/bin/fish
  [[ -x "$SHELL" ]] && exec "$SHELL" --login
else
  [[ -r $HOME/.bashrc ]] && . "$HOME/.bashrc"
fi
