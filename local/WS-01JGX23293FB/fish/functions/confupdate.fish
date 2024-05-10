function confupdate -d "Update configuration from GitHub"
    _confupdate
    or return

    # This server doesn't like `~/.ssh` (or any of its contents) being a symlink
    cp -af $USER_CONFIG_DIRS[2]/ssh/* ~/.ssh
    and chmod -R -c go-rwx ~/.ssh
end
