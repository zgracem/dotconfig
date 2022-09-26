if command -v brew >/dev/null; then
  export GIT_SSH_COMMAND=/usr/local/bin/ssh
  test -x "$GIT_SSH_COMMAND" || unset -v GIT_SSH_COMMAND
fi
