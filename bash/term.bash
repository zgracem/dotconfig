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
# Terminals
# -----------------------------------------------------------------------------

# See ~/etc/terminfo for custom .ti files + a script to compile & install them.
TERMINFO="$HOME/share/terminfo"

if [[ ! -d $TERMINFO ]]; then
  unset -v TERMINFO
else
  export TERMINFO
  export TERMINFO_DIRS="$TERMINFO:/usr/local/opt/ncurses/share/terminfo:/usr/share/terminfo"
  fixpath! TERMINFO_DIRS

  OLDTERM=$TERM

  # Darwin's full-screen system console
  if [[ $OLDTERM == vt100 && $OSTYPE =~ darwin && $(tty) == /dev/console ]]; then
    TERM=xnuppc
    export HV_DISABLE_PP=1
  fi

  if ! _inTmux && ! _inScreen; then
    # Old versions of Terminal.app
    if [[ $TERM_PROGRAM == Apple_Terminal && $OLDTERM != nsterm* ]]; then
      ver=${TERM_PROGRAM_VERSION%%.*} # Major version (integer) only
      case 1 in
        $(( ver >= 377 ))*)
          # macOS 10.12
          TERM=nsterm-build377
          ;;
        $(( ver >= 361 ))*)
          # OS X 10.11
          TERM=nsterm-build361
          ;;
        $(( ver >= 343 ))*)
          # OS X 10.10
          TERM=nsterm-build343
          ;;
        $(( ver >= 326 ))*)
          # OS X 10.9
          TERM=nsterm-build326
          ;;
        $(( ver >= 303 ))*)
          # OS X 10.7 & 10.8
          TERM=nsterm-256color
          ;;
        $(( ver >= 240 ))*)
          # OS X 10.5
          TERM=nsterm-16color
          ;;
        *)
          # This is probably god-awfully old; just leave it alone.
          : ;;
      esac
    
    # iTerm.app
    elif [[ $TERM_PROGRAM == "iTerm.app" && $OLDTERM != "iTerm.app" ]]; then
      TERM="iTerm.app"
    fi
  fi

  # Verify the new TERM setting before we proceed.
  if ! tput -T $TERM longname &>/dev/null; then
    scold "Error: tried to set TERM to unknown terminal $TERM"
    TERM=$OLDTERM
  fi
  unset -v OLDTERM
fi

# Change terminal line settings.
# Run this here to make sure `stty` has the best possible value for TERM.
if _inPath stty; then
  # Just say no to flow control.
  stty -ixon &>/dev/null

  # Set terminal to use hard tabs, 4 chars wide
  if _inPath tabs; then
    stty tab0
    tabs -4
  fi
fi

# Set the parent TERM so we can check capabilities of the actual emulator.
# Mark the variable readonly and export so it propagates to subshells.
if [[ -z $PTERM ]]; then
  if _inTmux || _inScreen; then
    # Try to guess the parent terminal from the value of TERM_PROGRAM, if any.
    case $TERM_PROGRAM in
      Apple_Terminal)
        PTERM=nsterm
        ;;
      iTerm.app)
        PTERM=iTerm.app
        ;;
      PuTTY)
        PTERM=putty-256color
        ;;
      *)
        : # Oh well, we tried.
        ;;
    esac
  else
    # Set it to the multiplexer's and hope for the best
    PTERM=$TERM
  fi

  declare -rx PTERM=${PTERM:-$TERM}
fi

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
  printf '%b%s%b' "$CAP_ts" "$*" "$CAP_fs"
}

settabtitle()
{ # set the tab title
  printf '%b%s%b' "${CAP_ts/2;/1;}" "$*" "$CAP_fs"
}

setbothtitles()
{
  setwintitle "$@"
  settabtitle "$@"
}
