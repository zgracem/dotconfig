unset -v GIT_EDITOR SUDO_EDITOR

# Set all default editors to vim
export EDITOR=vim
export VISUAL="$EDITOR"

# Use GUI app if not logged in remotely
if [ -z "$SSH_CONNECTION" ]; then
  if [ -x "$HOME/bin/code-wait" ]; then
    VISUAL="$HOME/bin/code-wait"
  elif [ -x "$HOME/bin/code" ]; then
    # The above solution is preferred because some things that use $VISUAL
    # check to see whether it exists. Since there is no file "code --wait" in
    # ~/bin, those things will fail. :(
    VISUAL="$HOME/bin/code --wait"
  fi
fi
