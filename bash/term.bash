# -----------------------------------------------------------------------------
# Control sequences
# -----------------------------------------------------------------------------

BEL=$'\a'   # 🔔
CSI=$'\e['  # Control Sequence Introducer
DCS=$'\eP'  # Device Control String
OSC=$'\e]'  # Operating System Command
 ST=$'\e\\' # String Terminator

# Device control strings: tmux and screen will only forward escape sequences to
# the terminal if wrapped in the appropriate DCS controls.
DCS_ante=""
DCS_post=""

if _inTmux; then
  DCS_ante="${DCS}tmux;\e"
  DCS_post="${ST}"
elif _inScreen; then
  DCS_ante="${DCS}"
  DCS_post="${ST}"
fi

# Sequences to change the window title
CAP_ts="${DCS_ante}${OSC}2;" # to_status_line
CAP_fs="${BEL}${DCS_post}"   # from_status_line

# -----------------------------------------------------------------------------
# Functions
# -----------------------------------------------------------------------------

rollback()
{
  tput cuu1 # move cursor up one line (printf "\eM")
  tput cr   # move cursor to beginning of line (printf "\r")
  tput el   # clear to end of line (printf "${CSI}K")
}

dtterm()
{
  local Ps="$1"
  printf "%b" "${DCS_ante}${CSI}${Ps}${DCS_post}"
}

mmin()
{ # minimize (iconify) window
  dtterm "2t"
  rollback
}

mmax()
{ # maximize (de-iconify) window
  dtterm "1t"
  rollback
}

setwintitle()
{ # set the xterm-compatible window title
  local title="$*"
  printf '%b%s%b' "$CAP_ts" "$title" "$CAP_fs"
}

settabtitle()
{ # set the tab title
  local title="$*"
  printf '%b%s%b' "${CAP_ts/2;/1;}" "$title" "$CAP_fs"
}

setbothtitles()
{
  setwintitle "$@"
  settabtitle "$@"
}
