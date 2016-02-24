[[ $OSTYPE =~ darwin ]] || return

airport()
{
    "/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport" "$@"
}

router()
{   # IP address of router
    netstat -rn \
    | sed -nE 's/^default +([[:digit:].]+).*$/\1/p'
}

localip()
{   # print local IP address
    ipconfig getifaddr $netcard
}

getmacaddr()
{   # get MAC address of WiFi card
    ifconfig $netcard \
    | sed -nE 's/^\s+ether ([[:xdigit:]:]+).*$/\1/p'
}
