function cleanup-chrome -d "Cleanup Google Chrome files"
    # N.B. The asterisk needs to stay outside the braces so $detritus
    # will only include "Google" subdirs if they actually exist.
    set -l detritus {,$HOME}/Library/{Launch{Agents,Daemons},Application Support,Caches,Preferences}/{Google,com.google.}*

    for dir in $detritus
        if path is -d $dir
            command rm -rfv $dir
            or sudo rm -rfv $dir
        end
    end
end
