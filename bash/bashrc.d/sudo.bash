if _inPath sudo; then
  # allow aliases to be sudo'ed
  alias sudo='sudo '
else
  # just pass through commands
  sudo() { $*; }
  return
fi
