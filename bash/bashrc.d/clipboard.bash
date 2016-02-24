[[ -t 0 && -z $MC_SID ]] || return

__line_copy()
{
    pbcopy <<< "$READLINE_LINE"
}

__line_cut()
{
    pbcopy <<< "$READLINE_LINE"
    READLINE_LINE=""
}

__line_paste()
{
    local buffer="$(pbpaste)"
    READLINE_LINE="${READLINE_LINE:0:$READLINE_POINT}${buffer}${READLINE_LINE:$READLINE_POINT}"
    READLINE_POINT=$(( READLINE_POINT + ${#buffer} ))
}

__line_copy_left() {
    pbcopy <<< "${READLINE_LINE:0:$READLINE_POINT}"
}

__line_copy_right() {
    pbcopy <<< "${READLINE_LINE:$READLINE_POINT}"
}

bind -x '"\C-xc":__line_copy'
bind -x '"\C-xx":__line_cut'
bind -x '"\C-xv":__line_paste'
bind -x '"\C-xa":__line_copy_left'
bind -x '"\C-xe":__line_copy_right'
