function confupdate -d "Update configuration directories from GitHub"
    set -l oldpwd $PWD
    for repo in dotconfig dotprivate
        cd ~/src/github.com/zgracem/$repo; and git pull
    end
    cd $oldpwd

    # This server doesn't like `~/.ssh` (or any of its contents) being a symlink
    cp -afv ~/src/github.com/zgracem/dotprivate/ssh/* ~/.ssh; or return
end
