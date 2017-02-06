[[ $PLATFORM == mac ]] || return

plist() { plutil -p "$1" | less -F; }
