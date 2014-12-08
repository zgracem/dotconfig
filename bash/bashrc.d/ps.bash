ps()
{
    # show processes from all users
    local flags_ps='-a'

    if _isGNU ps; then
        # summary format
        flags_ps+='s'

        if [[ $OSTYPE =~ cygwin ]]; then
            # also show Windows processes
            flags_ps+='W'
        fi
    else
        flags_ps+='xo pid,ppid,user,start,command'
    fi

    command ps $flags_ps "$@"
}
