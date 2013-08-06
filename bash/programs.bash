# -----------------------------------------------------------------------------
# ~zozo/.config/bash/programs
# say hello: printf "zozo\x40inescapable\x2eorg"
# -----------------------------------------------------------------------------

# set default values
BROWSER=$(getPath links)
EDITOR=$(getPath vim)
PAGER=$(getPath less)

VISUAL=$EDITOR
GIT_EDITOR=$EDITOR
SUDO_EDITOR=$EDITOR

if [[ ! $SSH_TTY ]]; then
    VISUAL=$dir_scripts/subl.sh

    case $OSTYPE in
        darwin*)
            BROWSER=/usr/bin/open
            ;;
        cygwin)
            BROWSER=$dir_scripts/chrome.sh
            ;;
    esac
fi

export BROWSER EDITOR GIT_EDITOR MANPAGER=$PAGER PAGER SUDO_EDITOR VISUAL
