# do not create function in Midnight Commander
if [[ -z $MC_SID ]]; then
    cd()
    {
        builtin pushd "${@:-$HOME}" 1>/dev/null
    }

    alias --  -='pushd +1 1>/dev/null'  # -  = go back 1 dir
    alias -- --='pushd -0 1>/dev/null'  # -- = go forward 1 dir
fi

cdls()
{   # change to, and immediately list, a directory
    cd "$@" && ls
}

cdll()
{   # change to, and immediately list (at length), a directory
    cd "$@" && ll
}

ccd()
{   # reset everything
    builtin cd      # move to $HOME
    builtin dirs -c # clear directory stack
    clear           # clear screen

    # clear scrollback in multiplexer
    if _inScreen; then
        screen -S "$STY" -X eval "scrollback 0" "scrollback 4096"
    elif _inTmux; then
        tmux clear-history
    fi

    # clear scrollback in terminal
    case $TERM_PROGRAM in
        PuTTY|Apple_Terminal)
            printf "%b" "${CSI}3J"
            ;;
        iTerm*)
            printf "%b" "${OSC}50;ClearScrollback${BEL}"
            ;;
    esac
}
