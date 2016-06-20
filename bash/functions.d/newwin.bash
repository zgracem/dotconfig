newwin()
{   # open in a new tmux/GNU screen window, if applicable
    # Usage: newwin [-t|--title TITLE] COMMAND [ARGS]

    local title_regex='^-?-t(itle)?$'
    local title cmd arg i=0
    local -a args

    if [[ $1 =~ $title_regex ]]; then
        title="$2"
        shift 2
    else
        title="${1##*/}"
        printf -v cmd %q "$1"
        shift
    fi

    if _inTmux; then
        until [[ $# -eq 0 ]]; do
            # printf -v args[$i] %q "$1"
            printf -v arg %q "$1"
            args[$i]=$arg
            ((i++))
            shift
        done

        command tmux new-window -n "$title" "$cmd ${args[*]}"
    elif _inScreen; then
        command screen -t "$title" $cmd "$@"
    else
        $cmd "$@"
    fi
}

splitwin()
{   # open in a new tmux windowpane, if applicable
    # Usage: splitwin COMMAND [ARGS]

    local cmd arg i=0
    local -a args

    if _inTmux; then
        until [[ $# -eq 0 ]]; do
            # printf -v args[$i] %q "$1"
            printf -v arg %q "$1"
            args[$i]=$arg
            ((i++))
            shift
        done

        command tmux split-window -h "$cmd ${args[*]}"
    else
        $cmd "$@"
    fi
}
