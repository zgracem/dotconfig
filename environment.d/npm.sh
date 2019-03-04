if command -v npm >/dev/null; then
  export npm_config_userconfig="$XDG_CONFIG_HOME/npm/npmrc"
  export npm_config_cache="$XDG_CACHE_HOME/npm"
  export npm_config_tmp="$XDG_RUNTIME_HOME/npm"
  # prevent creation of ~/.config/configstore
  export NO_UPDATE_NOTIFIER=true
fi
