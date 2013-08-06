# ------------------------------------------------------------------------------
# ~zozo/.config/bash/functions/newwin.bash
# ------------------------------------------------------------------------------

newwin()
{   # open in a new tmux/GNU screen window if applicable
    declare bin cmd title titleregex='^-?-t(itle)?$'

    [[ $1 =~ $titleregex ]] && {
        title="$2"
        shift 2
    } || {
        title="$(basename "$1")"
    }

    printf -v cmd "%q " $@

    if [[ $TMUX ]]; then
        tmux new-window -n "$title" "$cmd"
    elif [[ $STY ]]; then
        screen -t "$title" $cmd
    else
        $cmd
    fi
}
