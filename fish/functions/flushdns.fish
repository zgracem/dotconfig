function flushdns
    if is-macos
        sudo dscacheutil -flushcache
        and sudo killall -HUP mDNSResponder
    else if is-cygwin
        ipconfig /flushdns
    else
        echo >&2 "don't know how to flush DNS on this system!"
        return 1
    end
end
