h()
{ #: - context-sensitive help
  if help "$1" &>/dev/null; then
    help -m "$1" | less -F
  elif command man -w "$1" &>/dev/null; then
    man "$1"
  elif "$1" --help &>/dev/null; then
    "$1" --help | less -F
  else
    scold "${1}: help not found"
    return 1
  fi
}
