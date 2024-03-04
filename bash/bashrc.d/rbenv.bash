if [ -d "$RBENV_ROOT" ]; then
  # In case it isn't installed to /usr/local/bin
  [ -d "$RBENV_ROOT/bin" ] && PATH=$RBENV_ROOT/bin:$PATH

  if type -P rbenv >/dev/null; then
    eval "$(rbenv init -)"
    MANPATH="$(rbenv prefix)/share/man:$MANPATH"
    if declare -f fixpath >/dev/null; then
      PATH=$(fixpath "$PATH")
      MANPATH=$(fixpath "$MANPATH")
    fi
  fi
fi
