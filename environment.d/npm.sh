if command -v npm >/dev/null; then
  export npm_config_userconfig="$XDG_CONFIG_HOME/npm/npmrc"
  # prevent creation of ~/.config/configstore
  export NO_UPDATE_NOTIFIER=true
fi
