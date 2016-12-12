ps()
{
  set -- -a "$@"
  #       └─── show processes from all users

  if [ "$PLATFORM" = "windows" ]; then
    set -- -W "$@"
    #       └─ also show Windows processes
  fi

  if _isGNU ps; then
    set -- -s "$@"
    #       └─ summary format
  else
    set -- xo pid,ppid,user,start,command "$@"
    #      │└─ output this info (to match GNU ps)
    #      └── include processes w/ no controlling terminal
  fi

  command ps "$@"
}
