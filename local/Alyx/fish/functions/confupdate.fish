function confupdate -d "Update configuration directories from GitHub"
    for repo in dotconfig dotprivate
        git -C ~/src/github.com/zgracem/$repo pull
    end
end
