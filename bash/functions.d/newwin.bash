newwin()
{   # open in a new tmux/GNU screen window, if applicable
    # Usage: newwin [-t|--title TITLE] COMMAND [ARGS]

    local title_regex='^-?-t(itle)?$'
    local title cmd i=0
    local -a args

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

        command tmux new-window -n "$title" "$cmd ${args[*]}"
    elif [[ $STY ]]; then
        command screen -t "$title" $cmd "$@"
    else
        $cmd "$@"
    fi
}

splitwin()
{   # open in a new tmux windowpane, if applicable
    # Usage: splitwin COMMAND [ARGS]

    local cmd i=0
    local -a args

    if [[ $TMUX ]]; then
        until [[ $# -eq 0 ]]; do
            printf -v args[$i] "%q" "$1"
            ((i++))
            shift
        done

        command tmux split-window -h "$cmd ${args[*]}"
    else
        $cmd "$@"
    fi
}
