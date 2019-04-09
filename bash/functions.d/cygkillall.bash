[[ $OSTYPE == cygwin ]] || return

killall()
{ #: - kill a Cygwin process by name
  #: < pidof()
  #: < cygkill()
  local pid; if pid="$(pidof "$1")"; then
    cygkill "$pid"
  else
    scold 'No matching processes belonging to you were found'
    return 1
  fi
}
