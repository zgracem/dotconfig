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

map()
{   # applies a function to each item in a list
    # Usage: map COMMAND: ITEM [ITEM ...]
    # Based on: http://redd.it/aks3u

    declare i cmd

    if [[ $# -lt 2 ]] || [[ ! $@ =~ :[[:space:]] ]]; then
        scold "invalid syntax"
        return 1
    fi

    until [[ $1 =~ :$ ]]; do
        cmd+="$1 "
        shift
    done

    cmd+="${1%:} "
    shift

    for i in "$@"; do
        eval "${cmd//\\/\\\\} \"${i//\\/\\\\}\""
    done
}

ca()
{   # count arguments
    # https://github.com/tejr/dotfiles/blob/master/bash/bashrc.d/ca.bash

    printf '%d\n' "$#"
}
