[[ $PLATFORM == windows ]] || return

cygkill()
{ # kill a process by its Windows PID
  /bin/kill --force -SIGTERM "$@"
  #           │      └─ standard kill(1) signal
  #           └──────── use Win32 interface
}
