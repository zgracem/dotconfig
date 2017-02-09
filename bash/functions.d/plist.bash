[[ $PLATFORM == mac ]] || return

plist()
{ #: - display a .plist file in human-readable format
  plutil -p "$1" | less -F
}
