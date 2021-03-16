function cleanup-chrome
    set -l cask google-chrome # cf. google-chrome-{beta,dev,canary}
    test -d /usr/local/Caskroom/$cask; and brew rm --cask $cask

    # N.B. The asterisk needs to stay outside the braces so $detritus will only
    # pick up "Google" subdirs if they actually exist.
    set -l detritus {,$HOME}/Library/{Launch{Agents,Daemons},Application Support,Caches,Preferences}/{Google,com.google.}*
    test (count $detritus) -gt 0; or return

    rm -rf $detritus
end
