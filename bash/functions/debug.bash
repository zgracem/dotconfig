# ------------------------------------------------------------------------------
# ~zozo/.config/bash/functions/debug.bash
# handy functions for debugging and development
# ------------------------------------------------------------------------------

_shoptSet()
{   # exits 0 if shell option $1 is set
    [[ $BASHOPTS =~ $1 ]]
}

xtrace()
{   # toggle xtrace
    if [[ $SHELLOPTS =~ xtrace ]]; then
        set +o xtrace
    else
        set -o xtrace
    fi
}

q()
{   # exit code tester and wrapper for [[ ... ]]
    # Usage: q '-d /path/to/dir'
    #        q '-n $SSH_TTY'
    #        some_command; q

    declare lastExit=$? expr result qAnswer qColour

    case $# in
        0)
            expr="$lastExit -eq 0"
            ;;
        1)
            expr="$@"
            ;;
        *)
            scold "Usage: $FUNCNAME [EXPRESSION]\n'EXPRESSION' uses [[ ... ]] syntax"
            return 64
            ;;
    esac

    # test it
    result="$(eval "[[ $expr ]] && echo true" 2>&1)"

    case $result in
        *error*)
            # syntax error
            scold "$FUNCNAME" "bad expression"       
            return 64
            ;;
        *true*)
            # true
            qAnswer="true"
            qColour="${colour_true}"  # green
            ;;
        *)  # false
            qAnswer="false"
            qColour="${colour_false}" # red (set in colours.bash)
            ;;
    esac

    printf "%b%b%b\n" $qColour $qAnswer $colour_reset

    return 0
}
