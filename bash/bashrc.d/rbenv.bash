if [ -d "$HOME/.rbenv" ]; then
  # In case it isn't installed to /usr/local/bin
  [ -d "$HOME/.rbenv/bin" ] && PATH=$HOME/.rbenv/bin:$PATH

  if command -v rbenv >/dev/null; then
    eval "$(rbenv init -)"
    MANPATH="$(rbenv prefix)/share/man:$MANPATH"
  fi
fi
