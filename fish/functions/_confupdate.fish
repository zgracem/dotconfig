function _confupdate -d "Update configuration from GitHub"
    # This is the baseline function. Machine-specific behaviour is added by
    #   $XDG_CONFIG_HOME/local/*/fish/functions/confupdate.fish
    set -q USER_CONFIG_DIRS
    or set -gx USER_CONFIG_DIRS ~/.{config,private}

    for dir in $USER_CONFIG_DIRS
        set -l user_dir (path resolve $dir)
        git -C $user_dir fetch --prune
        and git -C $user_dir merge --ff-only
        or break
    end
    or return
end
