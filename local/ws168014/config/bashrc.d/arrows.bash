# because PuTTY doesn't seem to understand left/right arrows anymore
if [[ $TERM_PROGRAM == PuTTY ]] && _inTmux; then
  bind '"\e[1;2D": backward-char'
  bind '"\e[1;2C": forward-char'
fi
