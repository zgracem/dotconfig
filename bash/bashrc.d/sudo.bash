if _inPath sudo; then
    # allow aliases to be sudo'ed
    alias sudo='sudo '
else
    # just pass through commands
    sudo() { $*; }
    return
fi

rootme()
{   # temporarily become root for $1 minutes (default is 3)

    local def=5
    local tmout=$(( ${1:-$def} * 60 ))

    # rename window, if applicable
    if _inScreen; then
        printf '%b' "\eksudo${ST}"
    elif _inTmux; then
        quietly tmux rename-window sudo
    fi

    sudo \
        ${Z_SOLARIZED:+Z_SOLARIZED=$Z_SOLARIZED} \
        TMOUT=$tmout \
        -s
        # -p "%u "$'\xe2\x86\x92'" %U@%H: "

    # restore window name
    if _inScreen; then
        printf '%b' "\ekbash${ST}"
    elif _inTmux; then
        quietly tmux set-window-option automatic-rename on
    fi
}
