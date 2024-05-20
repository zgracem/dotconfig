function confupdate -d "Update configuration from GitHub"
    # This server's `git` is so old it doesn't support the `-C` flag
    set -gx USER_CONFIG_DIRS (path resolve ~/.{config,private})

    for dir in $USER_CONFIG_DIRS
        pushd $dir; and git pull; and popd
        or return
    end

    # This server doesn't like `~/.ssh` (or any of its contents) being a symlink
    cp -af $USER_CONFIG_DIRS[2]/ssh/* $HOME/.ssh
    and chmod -R -c go-rwx $HOME/.ssh
end
