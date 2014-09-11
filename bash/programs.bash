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

if _inPath mandb; then
    # don't let man-db use grotty to output SGR codes (preserves colour)
    export GROFF_NO_SGR=1

    # use less's default prompt in man pages
    export MANLESS=
fi

# use GUI apps if not logged in remotely
if [[ -z $SSH_CONNECTION ]]; then
    case $OSTYPE in
        darwin*)
            BROWSER=/usr/bin/open
            VISUAL="/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl"
            ;;
        cygwin)
            BROWSER=$dir_scripts/firefox.sh
            VISUAL=$dir_scripts/subl.sh
            ;;
    esac
fi

export BROWSER EDITOR GIT_EDITOR MANPAGER PAGER SUDO_EDITOR VISUAL
