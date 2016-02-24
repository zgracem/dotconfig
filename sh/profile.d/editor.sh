# set defaults
EDITOR=vim
VISUAL=$EDITOR
GIT_EDITOR=$EDITOR
SUDO_EDITOR=$EDITOR

# use GUI app if not logged in remotely
if test -z "$SSH_TTY"; then
    if test -d '/Applications/Sublime Text.app'; then
        VISUAL="$HOME/bin/subl-wait"

    elif test -x "$HOME/bin/subl"; then
        VISUAL="$HOME/bin/subl --wait"

    # elif test ":$OSTYPE:" = ':cygwin:'; then
    #     VISUAL="$HOME/scripts/subl.sh --wait"

    fi
fi

export EDITOR VISUAL GIT_EDITOR SUDO_EDITOR
