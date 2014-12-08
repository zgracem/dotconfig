if ! _inPath sudo; then
    # just pass through commands
    sudo() { $*; }

    return
fi

rootme()
{   # temporarily become root for $1 minutes (default is 3)

    local timeout=$(( ${1:-3} * 60 ))

    # rename window, if applicable
    if [[ $STY ]]; then
        echo -ne "\eksudo\e\\"
    elif [[ $TMUX ]]; then
        tmux rename-window sudo
    fi

    sudo \
        ${STY:+STY=$STY} \
        ${TMUX:+TMUX=$TMUX} \
        TMOUT=$timeout \
        -s

    # restore window name
    if [[ $STY ]]; then
        echo -ne "\ekbash\e\\"
    elif [[ $TMUX ]]; then
        quietly tmux set-window-option automatic-rename on
    fi
}

