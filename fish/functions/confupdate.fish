function confupdate -d "Update configuration directories from GitHub"
    set -f dirs

    switch $hostname
    case Alyx
        set -f dirs ~/src/**/dot{config,private}
    case "*"
        set -f dirs ~/.{config,private}
    end

    for dir in $dirs
        git -C (path resolve $dir) pull
    end

    switch $hostname
    case "*.opalstack.com" "WS-*"
        # These servers doesn't like `~/.ssh` (or any of its contents) being a symlink
        cp -af $dirs[2]/ssh/* $HOME/.ssh
        and chmod -R -c go-rwx $HOME/.ssh
    end
end
