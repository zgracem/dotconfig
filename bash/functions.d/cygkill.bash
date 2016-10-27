[[ $PLATFORM == windows ]] || return

cygkill()
{ # kill a process by its Windows PID
  /bin/kill --force -SIGTERM "$@"
  #           │      └─ standard kill(1) signal
  #           └──────── use Win32 interface
}

killall()
{ # kill a process by name

  local pid; if pid="$(pidof "$1")"; then
    cygkill "$pid"
  else
    scold 'No matching processes belonging to you were found'
    return 1
  fi
}
