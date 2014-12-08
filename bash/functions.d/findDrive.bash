[[ $OSTYPE =~ cygwin ]] || return

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
