function confupdate -d "Update configuration directories from GitHub"
    set -gx USER_CONFIG_DIRS ~/src/**/dot{config,private}

    _confupdate
end
