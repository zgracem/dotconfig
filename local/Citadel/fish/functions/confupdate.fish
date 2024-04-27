function confupdate -d "Update configuration from GitHub"
    set -q USER_CONFIG_DIRS
    or set -gx USER_CONFIG_DIRS ~/.{config,private}

    for dir in $USER_CONFIG_DIRS
        git -C (path resolve $dir) push
        or break
    end
    or return
end
