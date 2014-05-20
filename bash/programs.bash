# -----------------------------------------------------------------------------
# ~zozo/.config/bash/programs
# say hello: printf "zozo\x40inescapable\x2eorg"
# -----------------------------------------------------------------------------

# set default values

BROWSER=$(getPath links)

EDITOR=$(getPath vim)
VISUAL=$EDITOR
GIT_EDITOR=$EDITOR
SUDO_EDITOR=$EDITOR

PAGER=$(getPath less)
MANPAGER=$PAGER

# use GUI apps if not logged in remotely
if [[ -z $SSH_CONNECTION ]]; then
    case $OSTYPE in
        darwin*)
            BROWSER=/usr/bin/open
            VISUAL=/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl
            ;;
        cygwin)
            BROWSER=$dir_scripts/chrome.sh
            VISUAL=$dir_scripts/subl.sh
            ;;
    esac
fi

export BROWSER EDITOR GIT_EDITOR MANPAGER PAGER SUDO_EDITOR VISUAL
