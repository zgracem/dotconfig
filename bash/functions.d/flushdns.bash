if [[ $OSTYPE =~ darwin ]]; then
    flushdns()
    {   # This doesn't work on versions of OSX with that discoveryd(?) mess,
        # but hopefully I'll never need to use that again.
        dscacheutil -flushcache \
            && killall -HUP mDNSResponder &>/dev/null
    }
elif [[ $OSTYPE == cygwin ]]; then
    flushdns()
    {
        $(cygpath -au "$SYSTEMROOT\System32\ipconfig.exe") /flushdns
        # `ipconfig /?` gives really good documentation, incidentally.
    }
else
    return
fi
