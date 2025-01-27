function cleanup-office -d "Cleanup Microsoft Office files"
    set -f dirs {,$HOME}/Applications
    set -a dirs /Library/{LaunchAgents,LaunchDaemons,Preferences}
    set -a dirs ~/Library/{Application Support,Caches,Preferences}

    for file in $dirs/*{Microsoft,microsoft}*
        string match -q "*VSCode*" $file; and continue
        command rm -rfv $file
        or sudo rm -rfv $file
    end
end
