[[ $OSTYPE =~ cygwin ]] || return

cygkill()
{   # kill a process by its Cygwin PID
    /bin/kill --force --signal SIGTERM "$@"
}

killall()
{   # kill a process by name
    cygkill $(pidof $1)
}
