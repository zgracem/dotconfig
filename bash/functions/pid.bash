# ------------------------------------------------------------------------------
# ~zozo/.config/bash/functions/pid.bash
# ------------------------------------------------------------------------------

case $OSTYPE in
    cygwin)  flags_pid='-asW' ;;
    *)       flags_pid='-cx -o pid,command' ;;
esac

pidof()
{   # return the PID of process $1
    declare proc="$1"
    command ps $flags_pid |
    egrep -io "\<[[:digit:]]+ .*\<$proc[^\\]*(\.exe)?$" |
    cut -d" " -f1
}

pidis()
{   # return the process with PID $1
    declare pid="$1"
    command ps ${flags_pid/pid,/} -p $pid  |
    tail -n+2
}
