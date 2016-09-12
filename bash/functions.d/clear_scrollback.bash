clear_scrollback()
{
  # clear screen
  clear

  # clear scrollback in multiplexer
  if _inScreen; then
    screen -S "$STY" -X eval "scrollback 0" "scrollback 4096"
  elif _inTmux; then
    tmux clear-history
  fi

  # clear scrollback in terminal
  case $TERM_PROGRAM in
    PuTTY|Apple_Terminal)
      printf "%b" "${DCS_ante}${CSI}3J${DCS_post}"
      ;;
    iTerm*)
      printf "%b" "${OSC}50;ClearScrollback${BEL}"
      ;;
  esac
}
# [warn] kq_init: detected broken kqueue; not using.: Undefined error: 0
