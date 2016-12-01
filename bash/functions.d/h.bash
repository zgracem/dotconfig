# context-sensitive help
h()
{
  if help "$1" &>/dev/null; then
    help -m "$1" | less -F
  elif command man -w "$1" &>/dev/null; then
    man "$1"
  elif _inPath "$1" \
    && "$1" --help 2>/dev/null | less -F
  then
    return 0
  else
    scold "${1}: help not found"
    return 1
  fi
}
