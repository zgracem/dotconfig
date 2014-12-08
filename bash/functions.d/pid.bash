case $OSTYPE in
    cygwin)  flags_pid='-asW' ;;
    *)       flags_pid='-cx -o pid,command' ;;
esac

pidof()
{   # return the PID of process $1 or exit false
    local proc="$1"

    local pid=$(command ps $flags_pid \
        | sed -nE "s/[[:space:]]*([[:digit:]]+) .*\<$proc[^\\]*(\.exe)?$/\1/ip")

    if [[ -n $pid ]]; then
        echo "$pid"
    fi
}

pidis()
{   # return the process with PID $1 or exit false
    local pid="$1"

    local proc=$(command ps ${flags_pid/pid,/} -p $pid \
        | tail -n+2)

    if [[ -n $proc ]]; then
        echo "$proc"
    fi
}
