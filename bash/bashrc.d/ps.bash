ps()
{
    local flags_ps='-a'
    #                └─── show processes from all users

    if [[ $OSTYPE =~ cygwin ]]; then
        flags_ps+='W'
        #          └───── also show Windows processes
    fi

    if _isGNU ps; then
        flags_ps+='s'
        #          └───── summary format

    else
        flags_ps+='xo pid,ppid,user,start,command'
        #          │└──── output this info (to match GNU ps)
        #          └───── include processes w/ no controlling terminal
    fi

    command ps $flags_ps "$@"
}
