# ------------------------------------------------------------------------------
# ~zozo/.config/bash/functions/exits.bash
# check and generate useful exit codes
# ------------------------------------------------------------------------------

wtf()
{   # return/colourize exit status of last command
    declare lastExit=$?

    case $lastExit in
        0)  declare col="${colour_true}"  # green (set in colours.bash)
            ;;
        *)  declare col="${colour_false}" # red
            ;;
    esac

    printf "${col}$lastExit${colour_reset}\n"
}

q()
{   # exit code tester / wrapper for [[ ... ]]
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
            printf "Usage: %s [EXPRESSION]\n'EXPRESSION' uses [[ ... ]] syntax\n" $FUNCNAME 1>&2
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
        printf "%s: bad expression\n" $FUNCNAME 1>&2
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
