# ------------------------------------------------------------------------------
# ~zozo/.config/bash/functions/newwin.bash
# ------------------------------------------------------------------------------

newwin()
{   # open in a new tmux/GNU screen window, if applicable
    # Usage: newwin [-t|--title TITLE] COMMAND [ARGS]

    declare title_regex='^-?-t(itle)?$'
    declare title cmd i=0
    declare -a args

    if [[ $1 =~ $title_regex ]]; then
        title="$2"
        shift 2
    else
        title="${1##*/}"
        printf -v cmd "%q" "$1"
        shift
    fi

    if [[ $TMUX ]]; then
        until [[ $# -eq 0 ]]; do
            printf -v args[$i] "%q" "$1"
            ((i++))
            shift
        done

        tmux new-window -n "$title" "$cmd ${args[*]}"
    elif [[ $STY ]]; then
        screen -t "$title" $cmd "$@"
    else
        $cmd "$@"
    fi
}

export -f newwin

splitwin()
{   # open in a new tmux windowpane, if applicable
    # Usage: splitwin COMMAND [ARGS]

    declare cmd i=0
    declare -a args

    if [[ $TMUX ]]; then
        until [[ $# -eq 0 ]]; do
            printf -v args[$i] "%q" "$1"
            ((i++))
            shift
        done

        tmux split-window -h "$cmd ${args[*]}"
    else
        $cmd "$@"
    fi
}
