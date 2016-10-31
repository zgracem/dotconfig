command -v npm >/dev/null || return

# Keep homedir tidy.
z_tidy ~/.npmrc
export npm_config_userconfig="$XDG_CONFIG_HOME/npmrc"
