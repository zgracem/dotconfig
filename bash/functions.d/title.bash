# default title string
### ZGM disabled 2016-04-28 -- not using this, don't need it
# Z_WINTITLE_DEFAULT="${USER:-$(id -un)}@${HOSTNAME:-$(uname -n)}"

# typical escape codes
cap_tsl="${OSC}2;"      # to_status_line
cap_fsl="${BEL}"        # from_status_line

# ANSI Device Control Strings (http://serverfault.com/a/361639)
if _inTmux; then
    cap_tsl="${DCS}tmux;\e${cap_tsl}"
    cap_fsl="${cap_fsl}${ST}"
elif _inScreen; then
    cap_tsl="${DCS}${cap_tsl}"
    cap_fsl="${cap_fsl}${ST}"
fi

# export Z_WINTITLE_{PREFIX,ANTE,POST}

# -----------------------------------------------------------------------------

setwintitle()
{   # set the xterm-compatible window title
    local title="$@"
    printf '%b%s%b' "${cap_tsl}" "${title}" "${cap_fsl}"
}

settabtitle()
{   # set the tab title
    local title="$@"
    printf '%b%s%b' "${cap_tsl/2;/1;}" "${title}" "${cap_fsl}"
}

setbothtitles()
{
    setwintitle "$@"
    settabtitle "$@"
}
