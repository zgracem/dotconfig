[[ $PLATFORM == mac ]] || return

readplist() { plutil -p "$1" | less -F; }
