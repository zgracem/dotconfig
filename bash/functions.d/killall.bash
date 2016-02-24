[[ -x /usr/bin/killall && $OSTYPE =~ darwin ]] || return

killall()
{
    /usr/bin/killall -v "$@"
    #                 └─ verbose
}
