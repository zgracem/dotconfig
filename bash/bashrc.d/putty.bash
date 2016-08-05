[[ $TERM_PROGRAM == PuTTY ]] || return

mmin()
{  # minimize window
  
  local DCS_start=""
  local DCS_end=""

  if _inTmux; then
    DCS_start="${DCS}tmux;\e"
    DCS_end="${ST}"
  fi

  printf "%b" "${DCS_start}${CSI}2t${DCS_end}"

  tput cuu1 # move cursor up one line (printf "\eM")
  tput cr   # move cursor to beginning of line (printf "\r")
  tput el   # clear to end of line (printf "${CSI}K")
}
