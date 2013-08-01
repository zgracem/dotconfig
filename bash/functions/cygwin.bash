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
    declare drive
    for drive in /cygdrive/*; do
        if $(cygpath --sysdir)/cmd /c vol ${drive##*/}: 2>/dev/null | grep -i " $1$" &>/dev/null; then
            echo "$drive"
            return 0
        fi
    done
    return 1
}
