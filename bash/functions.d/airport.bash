[[ $OSTYPE =~ darwin ]] || return

# AirPort card (e.g. en1)
if [[ -z $netcard ]]; then
  netcard=$(scutil <<< "list" | sed -nE 's#^.*Setup:/Network/Interface/(en[[:digit:]])/AirPort$#\1#p')
fi

airport()
{
  "/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport" "$@"
}

router()
{ # IP address of router
  netstat -rn \
  | sed -nE 's/^default +([[:digit:].]+).*$/\1/p'
}

localip()
{ # print local IP address
  ipconfig getifaddr $netcard
}

getmacaddr()
{ # get MAC address of WiFi card
  ifconfig $netcard \
  | sed -nE 's/^\s+ether ([[:xdigit:]:]+).*$/\1/p'
}
