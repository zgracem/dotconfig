[[ $PLATFORM == windows ]] || return

killall()
{ # kill a process by name

  local pid; if pid="$(pidof "$1")"; then
    cygkill "$pid"
  else
    scold 'No matching processes belonging to you were found'
    return 1
  fi
}
