function dnsflush -d "Flush macOS's DNS cache"
    sudo dscacheutil -flushcache
    and sudo killall -HUP mDNSResponder
end
