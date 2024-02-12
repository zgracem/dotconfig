function confupdate -d "Update configuration directories from GitHub"
    for repo in .config .private
        git -C ~/$repo pull
    end
end
