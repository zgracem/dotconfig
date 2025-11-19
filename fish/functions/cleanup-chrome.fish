function cleanup-chrome -d "Cleanup Google Chrome files"
    set -l dirs {,$HOME}/Library/{Launch{Agents,Daemons},Application Support,Caches,Preferences}

    # The asterisk needs to stay outside the braces so the glob will only match
    # "Google" subdirs if they actually exist.
    for dir in $dirs/{Google,com.google.}*
        if path is -d $dir
            command rm -rfv $dir
            or sudo rm -rfv $dir
        end
    end
end
