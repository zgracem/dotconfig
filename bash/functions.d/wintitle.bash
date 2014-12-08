# default title string
title_prefix="${USER:-$(id -un)}@${HOSTNAME:-$(uname -n)}"

# typical escape codes
title_esc_ante="\e]2;"
title_esc_post="\a"

# ANSI Device Control Strings (http://serverfault.com/a/361639)
if [[ $TMUX ]]; then
    title_esc_ante="\ePtmux;\e$title_esc_ante"
    title_esc_post="$title_esc_post\e\\"
elif [[ $STY ]]; then
    title_esc_ante="\eP$title_esc_ante"
    title_esc_post="$title_esc_post\e\\"
fi

export title_prefix title_esc_{ante,post}

# -----------------------------------------------------------------------------

setWindowTitle()
{   # set the xterm-compatible window title
    if [[ $TERM =~ xterm|rxvt|putty|screen|cygwin ]]; then
        local title="${1:-$title_prefix}"
        printf '%b' "$title_esc_ante" "$title" "$title_esc_post"
    fi
}
