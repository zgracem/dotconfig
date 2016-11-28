command -v npm >/dev/null || return

# Keep homedir tidy.
export npm_config_userconfig="$XDG_CONFIG_HOME/npmrc"
