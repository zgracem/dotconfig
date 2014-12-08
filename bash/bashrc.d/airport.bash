# -----------------------------------------------------------------------------
# AirPort utilities
# -----------------------------------------------------------------------------

if ! [[ -x /System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport ]]; then
    return
fi

airport()
{
    /System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport "$@"
}

# -----------------------------------------------------------------------------

# WiFi network
# network=$(airport -I | sed -nE 's/^ +SSID: (.*)$/\1/p')

# AirPort card (e.g. en1)
if [[ -z $netcard ]]; then
    netcard=$(echo list \
        | scutil \
        | sed -nE 's#^.*Setup:/Network/Interface/(en[[:digit:]])/AirPort$#\1#p')
fi

# -----------------------------------------------------------------------------

airportusers()
{   # return number of users connected to AirPort
    snmpget -v 2c -c ${snmp_community} \
        -M+${snmp_mib_path} -m+${snmp_mib} \
        ${snmp_host}.local ${snmp_mib}::wirelessNumber.0 \
    | command grep -Eo --color=never '[[:digit:]+]$'
}

localip()
{   # local IP address
    ipconfig getifaddr ${netcard}
}

router()
{   # IP address of router
    netstat -rn \
    | sed -nE 's/^default +([[:digit:].]+).*$/\1/p'
}

getmac()
{   # MAC address of WiFi card
    ifconfig ${netcard} \
    | sed -nE 's/^\s+ether ([[:xdigit:]:]+).*$/\1/p'
}

flushdns()
{   # flush DNS cache
    if [[ $(uname -r) =~ ^14\. ]]; then
        sudo discoveryutil mdnsflushcache \
            && sudo discoveryutil udnsflushcaches
    else
        dscacheutil -flushcache \
            && killall -HUP mDNSResponder 2>/dev/null
    fi
}
