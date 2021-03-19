function cleanup-chrome
    # N.B. The asterisk needs to stay outside the braces so $detritus
    # will only include "Google" subdirs if they actually exist.
    set -l detritus {,$HOME}/Library/{Launch{Agents,Daemons},Application Support,Caches,Preferences}/{Google,com.google.}*
    test (count $detritus) -gt 0; or return

    rm -rf $detritus
end
