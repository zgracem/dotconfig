# ------------------------------------------------------------------------------
# ~zozo/.config/bash/functions/cygwin.bash
# ------------------------------------------------------------------------------

[[ $OSTYPE =~ cygwin ]] || return 1

# ------------------------------------------------------------------------------

f()
{   # open an Explorer window for the current/specified directory
    cygstart --explore "${1-.}"
}

findDrive()
{   # given a drive label, return its path under /cygdrive
    declare label="$1" drive

    for drive in /cygdrive/*; do
        $(cygpath --sysdir)/cmd /c vol ${drive##*/}: |
        grep -i "${label}$" &>/dev/null && {
            echo "$drive"
            return 0
        }
    done

    return 1
}

cygkill()
{   # kill a process by its Cygwin PID
    /bin/kill --force --signal SIGTERM "$@"
}

killall()
{   # kill a process by name
    cygkill $(pidof $1)
}
