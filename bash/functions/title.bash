# ------------------------------------------------------------------------------
# ~zozo/.config/bash/functions/title.bash
# functions to manipulate the xterm-compatible window title
# ------------------------------------------------------------------------------

# default title string
titlePrefix="${USER:-$(id -un)}@${HOSTNAME:-$(uname -n)}"

# typical escape codes
titleEscAnte="\e]2;"
titleEscPost="\a"

# ANSI Device Control Strings (per http://serverfault.com/a/361639)
[[ $STY ]] && {
    titleEscAnte="\eP$titleEscAnte"
    titleEscPost="$titleEscPost\e\\"
}

[[ $TMUX ]] && {
    titleEscAnte="\ePtmux;\e$titleEscAnte"
    titleEscPost="$titleEscPost\e\\"
}

export titlePrefix titleEsc{Ante,Post}

# -----------------------------------------------------------------------------

setWindowTitle()
{
    [[ $TERM =~ xterm|rxvt|putty|screen|cygwin ]] && {
        declare title="${1:-$titlePrefix}"
        printf "%b" "$titleEscAnte" "$title" "$titleEscPost"
    }
}

updateWindowTitle()
{
    [[ $TERM_PROGRAM != "Apple_Terminal" ]] && {
        # Terminal already shows $PWD in the title bar
        declare titleSuffix=": "${PWD/#$HOME/\~}
    }
    
    setWindowTitle "${titlePrefix}${titleSuffix}"
}
