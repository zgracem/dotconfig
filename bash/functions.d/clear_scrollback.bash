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
      printf "%b" "${CSI}3J"
      ;;
    iTerm*)
      printf "%b" "${OSC}50;ClearScrollback${BEL}"
      ;;
  esac
}
