# ------------------------------------------------------------------------------
# ~zozo/.config/bash/functions/cygwin.bash
# ------------------------------------------------------------------------------

[[ $OSTYPE =~ cygwin ]] \
    || return 1

# ------------------------------------------------------------------------------

f()
{   # open an Explorer window for the current/specified directory
    local here="${1-.}"
    cygstart --explore "$here"
}

reveal()
{   # reveal a file in Explorer instead of opening it

    local item="$1"

    if [[ -e $item ]]; then
        $(cygpath --windir)/explorer /select, $(cygpath -w "$item")
    elif [[ -z $item ]]; then
        scold "Usage: ${FUNCNAME} FILE"
        return 64
    else
        scold "${item}: not found"
    fi
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

whatpkg()
{   # find the Cygwin package to which $1 belongs

    declare file="$1" package error

    if [[ ! -f $file ]]; then
        file="$(getPath "$file")" || {
            scold "$1: not found"
            return 1
        }
    fi

    package="$(cygcheck --find-package "$file")"

    if [[ -n $package ]]; then
        echo "$package"
    else
        scold "$file: does not seem to belong to a Cygwin package"
    fi
}

cmd()
{   # run a command from the Windows command line
    if [[ $# -eq 0 ]]; then
        cygstart $(cygpath -au $COMSPEC)
    else
        $(cygpath -au $COMSPEC) /c "$@"
    fi
}
