if command -v npm >/dev/null; then
  export npm_config_userconfig="$XDG_CONFIG_HOME/npmrc"
  export npm_config_cache="$XDG_CACHE_HOME/npm"
fi
