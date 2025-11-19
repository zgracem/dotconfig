if [[ $- == *i* && $SHLVL -lt 2 ]]; then
  # Launch fish (while keeping /bin/bash as login shell)
  SHELL=/home/linuxbrew/.linuxbrew/bin/fish
  [[ -x "$SHELL" ]] && exec "$SHELL" --login
else
  [[ -r $HOME/.bashrc ]] && . "$HOME/.bashrc"
fi
