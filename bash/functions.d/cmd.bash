[[ $OSTYPE =~ cygwin ]] || return

cmd()
{   # run a command from the Windows command line

	local cmd_exe="$(cygpath -au "${COMSPEC:-/cygdrive/c/Windows/system32/cmd.exe}")"

    if (( $# == 0 )); then
        cygstart "$cmd_exe"
    else
        "$cmd_exe" /c "$@"
    fi
}
