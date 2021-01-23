if command -sq npm
    set -gx npm_config_userconfig $XDG_CONFIG_HOME/npm/npmrc

    # prevent creation of ~/.config/configstore
    set -gx NO_UPDATE_NOTIFIER true
end
