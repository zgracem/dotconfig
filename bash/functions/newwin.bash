# ------------------------------------------------------------------------------
# ~zozo/.config/bash/functions/newwin.bash
# ------------------------------------------------------------------------------

newwin()
{   # open in a new tmux/GNU screen window if applicable
    # Usage: newwin [-t|--title TITLE] COMMAND ARGS ...

    declare bin arg i=0
    declare title titleregex='^-?-t(itle)?$'
    declare -a args

    [[ $1 =~ $titleregex ]] && {
        title="$2"
        shift 2
    } || {
        title="$(basename "$1")"
        printf -v bin "%q" "$1"
        shift
    }

    if [[ $TMUX ]]; then
        until [[ $# -eq 0 ]]; do
            printf -v args[$i] "%q" "$1"
            ((i++))
            shift
        done
        tmux new-window -n "$title" "$bin ${args[*]}"
    elif [[ $STY ]]; then
        screen -t "$title" $bin "$@"
    else
        $bin "$@"
    fi
}
