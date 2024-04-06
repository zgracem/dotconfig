function confupdate -d "Update configuration directories from GitHub"
    for repo in dotconfig dotprivate
        git -C ~/src/github.com/zgracem/$repo pull
    end

    # This server doesn't like `~/.ssh` (or any of its contents) being a symlink
    cd ~/.ssh; or return
    cp -afv ~/src/github.com/zgracem/dotprivate/ssh/* .; or return
end
