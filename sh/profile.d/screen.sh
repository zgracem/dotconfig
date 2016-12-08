ss()
{ # reattach a session; detach/create it first if necessary
  command screen -d -R "$@"
  #               │  └─ reattach a session if one exists, otherwise create it
  #               └──── detach existing session if necessary
}
