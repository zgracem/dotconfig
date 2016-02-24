[[ $OSTYPE =~ cygwin ]] || return

findDrive()
{   # given a drive label, return its path under /cygdrive

    local label="$1"
    local cmd_exe=$(cygpath -au "${COMSPEC:-/cygdrive/c/Windows/system32/cmd.exe}")

    local letter drive
    for letter in {d..l}; do
        drive="/cygdrive/$letter"

        if [[ -d $drive ]]; then
            "$cmd_exe" /c vol ${letter}: 2>/dev/null \
            | grep -iq "${label}$" \
                && { echo "$drive"; return 0; }
        fi
    done

    return 1
}
