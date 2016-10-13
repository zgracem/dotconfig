[[ $OSTYPE == darwin* ]] || return

localip()
{ # print local IP address
  local card # AirPort card (e.g. en1)
  card=$(scutil <<< "list" \
            | sed -nE 's#^.*Setup:/Network/Interface/(en[[:digit:]])/AirPort$#\1#p') \
    || return
  ipconfig getifaddr "$card"
}
