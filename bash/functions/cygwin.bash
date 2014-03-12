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
    declare drive letter cmdexe="$(cygpath -au $COMSPEC)"
    declare label="$1"

    for letter in {d..l}; do
        drive="/cygdrive/$letter"

        if [[ -d $drive ]]; then
            "$cmdexe" /c vol ${letter}: 2>/dev/null \
            | grep -iq "${label}$" && {
                echo "$drive"
                return 0
            }
        fi
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

sudo()
{   # pass through commands
    $*
}
