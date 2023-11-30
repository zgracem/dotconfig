# -----------------------------------------------------------------------------
# ~/.config/bash/_terminal.bash
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

if [[ -S "${TMUX%%,*}" ]] || [[ $PTERM == tmux-256color ]]; then
  DCS_ante="${DCS}tmux;\\e"
  DCS_post="${ST}"
elif [[ -n "$STY" && -p "$SCREENDIR/$STY" ]] || [[ $PTERM == screen-256color ]]; then
  DCS_ante="${DCS}"
  DCS_post="${ST}"
fi

# Sequences to change the window title
CAP_ts="${DCS_ante}${OSC}2;" # to_status_line
CAP_fs="${BEL}${DCS_post}"   # from_status_line

# -----------------------------------------------------------------------------
# Functions
# -----------------------------------------------------------------------------

setwintitle()
{ #: -- sets the xterm-compatible window title
  local title="$*"
  printf '%b%s%b' "$CAP_ts" "$title" "$CAP_fs"
}

settabtitle()
{ #: -- sets the tab title
  local title="$*"
  printf '%b%s%b' "${CAP_ts/2;/1;}" "$title" "$CAP_fs"
}

setbothtitles()
{
  setwintitle "$@"
  settabtitle "$@"
}
