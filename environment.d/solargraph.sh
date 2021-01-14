if test -n "$XDG_CACHE_HOME"; then
  export SOLARGRAPH_CACHE="${XDG_CACHE_HOME:-$HOME/var/cache}/solargraph/cache"

  if test ! -d "$SOLARGRAPH_CACHE"; then
    mkdir -p "$SOLARGRAPH_CACHE"
  fi
fi
