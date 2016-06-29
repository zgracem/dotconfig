# typical escape codes
CAP_ts="${OSC}2;"      # to_status_line
CAP_fs="${BEL}"        # from_status_line

# tmux will only forward escape sequences to the terminal if surrounded by
# the appropriate DCS (Device Control String) sequences.
if _inTmux; then
    CAP_ts="${DCS}tmux;\e${CAP_ts}"
    CAP_fs="${CAP_fs}${ST}"
elif _inScreen; then
    CAP_ts="${DCS}${CAP_ts}"
    CAP_fs="${CAP_fs}${ST}"
fi

# -----------------------------------------------------------------------------

setwintitle()
{ # set the xterm-compatible window title
  printf '%b%s%b' "$CAP_ts" "$*" "$CAP_fs"
}

settabtitle()
{ # set the tab title
  printf '%b%s%b' "${CAP_ts/2;/1;}" "$*" "$CAP_fs"
}

setbothtitles()
{
  setwintitle "$@"
  settabtitle "$@"
}
