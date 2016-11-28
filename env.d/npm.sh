npm_config_userconfig="$XDG_CONFIG_HOME/npmrc"

if command -v npm >/dev/null; then
  export npm_config_userconfig
else
  unset -v npm_config_userconfig
fi
