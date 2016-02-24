[[ $OSTYPE =~ cygwin ]] || return

winkill()
{   # kill a process by its Windows PID
    /bin/kill --force --signal SIGTERM "$@"
}

killall()
{   # kill a process by name

    local pid

    if pid="$(pidof $1)"; then
        winkill "$pid"
    else
        scold 'No matching processes belonging to you were found'
        return 1
    fi
}
