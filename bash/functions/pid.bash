# ------------------------------------------------------------------------------
# ~zozo/.config/bash/functions/pid.bash
# ------------------------------------------------------------------------------

case $OSTYPE in
    cygwin)  flags_pid='-asW' ;;
    *)       flags_pid='-cx -o pid,command' ;;
esac

pidof()
{   # return the PID of process $1 or exit false
    declare proc="$1" pid

    pid=$(command ps $flags_pid |
        egrep -io "\<[[:digit:]]+ .*\<$proc[^\\]*(\.exe)?$" |
        cut -d" " -f1)
    
    [[ $pid ]] && echo "$pid"
}

pidis()
{   # return the process with PID $1 or exit false
    declare pid="$1" proc
    proc=$(command ps ${flags_pid/pid,/} -p $pid  |
        tail -n+2)

    [[ $proc ]] && echo "$proc"
}
