unset -v GIT_EDITOR SUDO_EDITOR

# Set all default editors to vim
export EDITOR=vim
export VISUAL="$EDITOR"

# Use GUI app if not logged in remotely
if [ -z "$SSH_CONNECTION" ]; then
  VISUAL="$HOME/bin/code-wait"
fi
