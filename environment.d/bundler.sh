if command -v bundle >/dev/null; then
  export BUNDLE_USER_CONFIG="$XDG_CONFIG_HOME/bundle/config"
  export BUNDLE_USER_CACHE="$XDG_CACHE_HOME/bundler"
  export BUNDLE_USER_PLUGIN="$XDG_DATA_HOME/bundler"
fi

return 0
