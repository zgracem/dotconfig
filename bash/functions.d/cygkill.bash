[[ $OSTYPE == cygwin ]] || return

cygkill()
{ #: - kill a process by its Windows PID
  #: @ killall()
  /bin/kill --force -SIGTERM "$@"
  #           │      └─ standard kill(1) signal
  #           └──────── use Win32 interface
}
