# default title string
title_default="${USER:-$(id -un)}@${HOSTNAME:-$(uname -n)}"

# typical escape codes
cap_tsl="${OSC}2;"      # to_status_line
cap_fsl="${BEL}"        # from_status_line

# ANSI Device Control Strings (http://serverfault.com/a/361639)
if _inTmux; then
    cap_tsl="${DCS}tmux;\e$cap_tsl"
    cap_fsl="$cap_fsl${ST}"
elif _inScreen; then
    cap_tsl="${DCS}$cap_tsl"
    cap_fsl="$cap_fsl${ST}"
fi

export title_{prefix,ante,post}

# -----------------------------------------------------------------------------

setwintitle()
{   # set the xterm-compatible window title
    local title="$@"
    printf '%b' "$cap_tsl" "$title" "$cap_fsl"
}

settabtitle()
{   # set the tab title
    local title="$@"
    printf '%b' "${cap_tsl/2;/1;}" "$title" "$cap_fsl"
}

setbothtitles()
{
    setwintitle "$@"
    settabtitle "$@"
}
