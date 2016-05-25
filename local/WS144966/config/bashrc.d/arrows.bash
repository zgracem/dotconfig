# because PuTTY doesn't seem to understand left/right arrows anymore
if _inTmux; then
  bind '"\e[1;2D": backward-char'
  bind '"\e[1;2C": forward-char'
fi
