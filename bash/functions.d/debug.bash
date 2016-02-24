xtrace()
{
    if [[ :$SHELLOPTS: =~ :xtrace: ]]; then
        # turn it off
        set +o xtrace
    else
        set -o xtrace
    fi
}

return # TODO: finish

# BASH_XTRACEFD introduced in v4.1
(( BASH_VERSINFO[0] >= 4 )) && (( BASH_VERSINFO[1] >= 1 )) || return

debug()
{
    if [[ :$SHELLOPTS: =~ :xtrace: ]]; then
        # turn it off immediately
        set +o xtrace

        # close our fd
        exec 4>&-

        # remind us where the log is
        echo "$BASH_XTRACELOG"

        # tidy up
        PS4=$OLDPS4
        unset -v BASH_XTRACEFD BASH_XTRACELOG OLDPS4

    else
        # create log in TMPDIR, capture filename, & output for reference
        export BASH_XTRACELOG=$(printf "$HOME/var/log/debug.$$.log" | tee /dev/stdout)
        # export BASH_XTRACELOG=$(mktemp -q -t "debug.$$.log" | tee /dev/stdout)

        # save PS4 and change it to something helpful
        export OLDPS4=$PS4
        export PS4='+$BASH_SOURCE:$LINENO:$FUNCNAME: '

        # set up a new file descriptor
        exec 4>>"$BASH_XTRACELOG"

        # tell bash to send xtrace output to our new fd
        BASH_XTRACEFD=4

        # turn on xtrace
        set -o xtrace
    fi
}
