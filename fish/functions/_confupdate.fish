function _confupdate -d "Update configuration directories from GitHub"
    set -q USER_CONFIG_DIRS
    or set -gx USER_CONFIG_DIRS ~/.{config,private}

    for dir in $USER_CONFIG_DIRS
        git -C (path resolve $dir) pull
        or break
    end
    or return
end
