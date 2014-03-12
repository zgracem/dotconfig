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

    declare lastExit=$? expr pipefailChanged qColour qAnswer

    case $# in
        0)
            expr="$lastExit -eq 0"
            ;;
        1)
            expr="$@"
            ;;
        *)
            scold "Usage: $FUNCNAME [EXPRESSION]\n'EXPRESSION' uses [[ ... ]] syntax"
            return 1
            ;;
    esac

    # disable pipefail if it's on
    [[ $SHELLOPTS =~ pipefail ]] && {
        set +o pipefail &&
        pipefailChanged=true
    }

    # check for syntax errors
    eval "[[ $expr ]]" 2>&1 | grep -q error && {
        scold "$FUNCNAME" "bad expression"
        [[ $pipefailChanged ]] && set -o pipefail
        return 64
    }

    # finally, test it
    if eval "[[ $expr ]]"; then
        qAnswer="true"
        qColour="${colour_true}"  # green (set in colours.bash)
    else
        qAnswer="false"
        qColour="${colour_false}" # red
    fi

    printf "%b%b%b\n" $qColour $qAnswer $colour_reset

    # turn pipefail back on if it was
    [[ $pipefailChanged ]] && set -o pipefail

    return 0
}
