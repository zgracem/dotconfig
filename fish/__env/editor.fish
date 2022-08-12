set --erase GIT_EDITOR
set --erase SUDO_EDITOR

# Set all default editors to vim
set -gx EDITOR vim
set -gx VISUAL $EDITOR

# Use GUI app for VISUAL if not logged in remotely
if not set -q SSH_CONNECTION
    if path is -x $HOME/bin/code-wait
        set VISUAL "$HOME/bin/code-wait"
    else if path is -x $HOME/bin/code
        # The above solution is preferred because some things that use $VISUAL
        # check to see whether it exists. Since there is no file "code --wait"
        # in ~/bin, those things will fail. :(
        set VISUAL "$HOME/bin/code --wait"
    end
end
