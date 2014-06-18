# ------------------------------------------------------------------------------
# ~zozo/.config/bash/functions/debug.bash
# handy functions for debugging and development
# ------------------------------------------------------------------------------

_optSet()
{   # exits 0 if all shell variables in $@ are set
    
    declare opt

    for opt in "$@"; do
        [[ :$SHELLOPTS: =~ :$opt: ]] || return 1
    done
}

_shoptSet()
{   # exits 0 if all shell options in $@ are set
    builtin shopt -pq $*
}

xtrace()
{   # toggle xtrace
    if _optSet xtrace; then
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
            qColour="${esc_true}"  # green
            ;;
        *)  # false
            qAnswer="false"
            qColour="${esc_false}" # red (set in colours.bash)
            ;;
    esac

    printf "%b%b%b\n" $qColour $qAnswer $esc_reset

    return 0
}

map()
{   # applies a function to each item in a list
    # Usage: map COMMAND: ITEM [ITEM ...]
    # Based on: http://redd.it/aks3u

    declare usage="$FUNCNAME COMMAND: ITEM [ITEM ...]"
    declare i cmd

    if [[ $# -lt 2 ]] || [[ ! $@ =~ :[[:space:]] ]]; then
        scold $FUNCNAME "invalid syntax"
        scold "Usage: $usage"
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

explode()
{   # expands and displays an array
    declare arrayName="$1" cmd key

    cmd="$(declare -p $arrayName 2>&1)"

    case $cmd in
        declare\ -[aA]*)
            # transfer $1 to our own array
            eval "${cmd/$arrayName/array}"

            for key in ${!array[*]}; do
                echo "[$key]=${array[$key]}"
            done

            return 0
            ;;
        declare*)
            scold "$FUNCNAME" "$arrayName: not an array"
            ;;
        *not\ found)
            scold "$FUNCNAME" "$arrayName: not found"
            ;;
    esac

    return 1
}
