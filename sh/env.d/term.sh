[ "$TERM" = "dumb" ] && return

# See ~/etc/terminfo for custom .ti files + a script to compile & install them.
export TERMINFO="$XDG_DATA_HOME/terminfo"

# TERMCAP will override TERMINFO if set (e.g. by GNU screen)
unset -v TERMCAP

if [ ! -d "$TERMINFO" ]; then
  unset -v TERMINFO
else
  export TERMINFO_DIRS="$TERMINFO:$HOMEBREW_PREFIX/opt/ncurses/share/terminfo:/usr/share/terminfo"
  TERMINFO_DIRS="$(fixpath "$TERMINFO_DIRS")"

  OLDTERM="$TERM"

  # Darwin's full-screen system console
  if [ "$OLDTERM" = "vt100" ] && [ "$PLATFORM" = "mac" ] && [ "$(tty)" = "/dev/console" ]; then
    TERM=xnuppc
  fi

  # mintty
  if [ "$OLDTERM" = "mintty-256color" ] || [ "$MSYSCON" = "mintty.exe" ] || command ps -p "$PPID" 2>&1 | grep -q mintty; then
    TERM_PROGRAM=mintty
    TERM=mintty
  fi

  # Visual Studio Code
  if [ "$TERM_PROGRAM" = "vscode" ]; then
    TERM=xterm-256color
  fi

  if [ ! -S "${TMUX%%,*}" ] && [ ! -p "$SCREENDIR/$STY" ]; then
    # Old versions of Terminal.app
    if [ "$TERM_PROGRAM" = "Apple_Terminal" ] && ! echo "$OLDTERM" | grep -q nsterm; then
      ver="${TERM_PROGRAM_VERSION%%.*}" # Major version (integer) only
      # Deliberately use a constant here to test truthiness
      # shellcheck disable=SC2194
      case 1 in
        $((ver >= 433))*) # macOS 10.15
          TERM=nsterm
          ;;
        $((ver >= 421))*) # macOS 10.14
          TERM=nsterm
          ;;
        $((ver >= 400))*) # macOS 10.13
          TERM=nsterm-build400
          ;;
        $((ver >= 377))*) # macOS 10.12
          TERM=nsterm-build377
          ;;
        $((ver >= 361))*) # OS X 10.11
          TERM=nsterm-build361
          ;;
        $((ver >= 343))*) # OS X 10.10
          TERM=nsterm-build343
          ;;
        $((ver >= 326))*) # OS X 10.9
          TERM=nsterm-build326
          ;;
        $((ver >= 303))*) # OS X 10.7 & 10.8
          TERM=nsterm-256color
          ;;
        $((ver >= 240))*) # OS X 10.5
          TERM=nsterm-16color
          ;;
        *) # This is probably god-awfully old; just leave it alone.
          :
          ;;
      esac

    # iTerm.app
    elif [ "$TERM_PROGRAM" = "iTerm.app" ] && [ "$OLDTERM" != "iTerm.app" ]; then
      TERM="iTerm2.app"
    fi
  fi

  # Verify the new TERM setting before we proceed.
  if ! tput -T "$TERM" longname >/dev/null 2>&1; then
    # echo "Error: tried to set TERM to unknown terminal $TERM" >&2
    TERM="$OLDTERM"
  fi
  unset -v OLDTERM
fi

# Set the parent TERM so we can check capabilities of the actual emulator.
# Mark the variable readonly and export so it propagates to subshells.
if [ -z "$PTERM" ]; then
  if [ -S "${TMUX%%,*}" ] || [ -p "$SCREENDIR/$STY" ]; then
    # Try to guess the parent terminal from the value of TERM_PROGRAM, if any.
    case "$TERM_PROGRAM" in
      Apple_Terminal)
        PTERM=nsterm
        ;;
      iTerm.app)
        PTERM=iTerm2.app
        ;;
      mintty)
        PTERM=mintty
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
    PTERM="$TERM"
  fi

  readonly PTERM="${PTERM:-$TERM}"
  export PTERM
fi

# Get the terminal colour depth (based on $TERM, not perfect but it'll do)
TERM_COLOURDEPTH="$(tput -T"$PTERM" colors 2>/dev/null ||
                    tput -T"$PTERM" Co 2>/dev/null)"
export TERM_COLOURDEPTH=${TERM_COLOURDEPTH:=-1}
