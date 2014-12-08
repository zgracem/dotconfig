# set defaults
EDITOR=vim
VISUAL=$EDITOR
GIT_EDITOR=$EDITOR
SUDO_EDITOR=$EDITOR

# use GUI app if not logged in remotely
if [ -z "$SSH_CONNECTION" ]; then
    if [ -d '/Applications/Sublime Text.app' ]; then
        VISUAL='/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl --wait'
    elif [ -x "$HOME/bin/subl" ]; then
        VISUAL="$HOME/bin/subl --wait"
    # elif [ ":$OSTYPE:" = ':cygwin:' ]; then
    #     VISUAL="$HOME/scripts/subl.sh --wait"
    fi
fi

export EDITOR VISUAL GIT_EDITOR SUDO_EDITOR
