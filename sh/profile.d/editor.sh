unset -v EDITOR VISUAL GIT_EDITOR SUDO_EDITOR

# Set all default editors to vim
EDITOR=vim
VISUAL=$EDITOR
GIT_EDITOR=$EDITOR
SUDO_EDITOR=$EDITOR

# Use GUI app if not logged in remotely.
if [ -z "$SSH_CONNECTION" ]; then
  if [ -x "$HOME/bin/subl-wait" ]; then
    VISUAL="$HOME/bin/subl-wait"
  elif [ -x "$HOME/bin/subl" ]; then
    # The above solution is preferred because some things that use $VISUAL
    # check to see whether it exists. Since there is no file "subl --wait" in
    # ~/bin, those things will fail. :(
    VISUAL="$HOME/bin/subl --wait"
  fi
fi

GIT_EDITOR=$VISUAL

export EDITOR VISUAL GIT_EDITOR SUDO_EDITOR
