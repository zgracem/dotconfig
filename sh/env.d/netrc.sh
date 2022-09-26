export NETRC="$HOME/.private/"
test -f "$NETRC.netrc" || unset -v NETRC
