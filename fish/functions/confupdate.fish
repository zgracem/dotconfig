function confupdate -d "Update configuration directories from GitHub"
    set -f dirs

    switch $hostname
    case Alyx phosphor.pink "*.opalstack.com"
        set -f dirs ~/src/github.com/zgracem/dot{config,private}
    case "*"
        set -f dirs ~/.{config,private}
    end

    for dir in $dirs
        git -C $dir pull
    end

    if string match -q "*.opalstack.com" $hostname
        # This server doesn't like `~/.ssh` (or any of its contents) being a symlink
        cp -af $dirs[2]/ssh/* $HOME/.ssh
        and chmod -R -c go-rwx $HOME/.ssh
    end
end
