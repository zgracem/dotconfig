[[ $OSTYPE == cygwin ]] || return

startxwin()
{
  export DISPLAY=":0"

  local -a xwin_opts=()
  xwin_opts+=(-auth ~/.Xauthority) # Use local authority file
  xwin_opts+=(-clipboard)          # Integrate X11 & system clipboards
  xwin_opts+=(-listen tcp)         # Listen for X11-forwarding TCP connections
  xwin_opts+=(-multiwindow)        # X-windows display as Windows-windows
  xwin_opts+=(-silent-dup-error)   # Fail silently if already running on DISPLAY

  echo "Starting XWin server..."
  ENV="$HOME/.bashrc" TERM_COLOURDEPTH= TERM_PROGRAM= \
    run /usr/bin/XWin "$DISPLAY" "${xwin_opts[@]}" || return

  echo "Waiting for server to load..."
  sleep 2

  echo "Merging .Xresources..."
  xrdb -display "$DISPLAY" -merge ~/.config/x11/Xresources
}

xterm()
{
  xrdb -display "$DISPLAY" -merge ~/.config/x11/Xresources || return
  command xterm
}

# Relaunch xterm from w/in xterm:
#   xrdb -display "$DISPLAY" ~/.config/x11/Xresources && command xterm & disown; exit
