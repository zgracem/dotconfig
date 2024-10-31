if [[ $- == *i* ]]; then
  HOMEBREW_PREFIX=/home/linuxbrew/.linuxbrew
  SHELL=$HOMEBREW_PREFIX/bin/fish
  [[ -x "$SHELL" ]] && exec "$SHELL" --login
else
  true
fi
