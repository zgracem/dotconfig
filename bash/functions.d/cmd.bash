[[ $OSTYPE =~ cygwin ]] || return

cmd()
{   # run a command from the Windows command line
    if [[ $# -eq 0 ]]; then
        cygstart $(cygpath -au $COMSPEC)
    else
        $(cygpath -au $COMSPEC) /c "$@"
    fi
}
