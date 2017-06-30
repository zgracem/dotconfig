[[ $PLATFORM == mac ]] || return

localip()
{ # print local IP address
  local card # AirPort card (e.g. en1)
  card=$(scutil <<< "list Setup:/Network/Interface/[^/]+/AirPort" \
            | grep -o 'en[[:digit:]]+') \
    || return
  ipconfig getifaddr "$card"
}
