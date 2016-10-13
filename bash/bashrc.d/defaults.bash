# -----------------------------------------------------------------------------
# coreutils
# -----------------------------------------------------------------------------

cp()
{
  command cp -aiv "$@"
  #           ││└─ verbose
  #           │└── interactive
  #           └─── archive mode (recursive;
  #                              don't follow symlinks;
  #                              preserve attributes)
}

ln()
{
  command ln -v "$@"
  #           └─ verbose
}

mkdir()
{
  command mkdir -pv "$@"
  #              │└─ verbose
  #              └── create parents as required
}

mv()
{
  local -a flags_mv=(-iv)
  #                   │└─ verbose
  #                   └── interactive

  if [[ $OSTYPE == darwin* ]]; then
    # http://brettterpstra.com/2014/07/04/how-to-lose-your-tags/
    /bin/mv "${flags_mv[@]}" "$@"
  else
    command mv "${flags_mv[@]}" "$@"
  fi
}
  
rm()
{
  command rm -iv "$@"
  #           │└─ verbose
  #           └─── interactive
}

# -----------------------------------------------------------------------------
# ps
# -----------------------------------------------------------------------------

ps()
{
  local flags_ps='-a'
  #                └─── show processes from all users

  if [[ $OSTYPE =~ cygwin ]]; then
    flags_ps+='W'
    #          └───── also show Windows processes
  fi

  if _isGNU ps; then
    flags_ps+='s'
    #          └───── summary format

  else
    flags_ps+='xo pid,ppid,user,start,command'
    #          │└──── output this info (to match GNU ps)
    #          └───── include processes w/ no controlling terminal
  fi

  command ps $flags_ps "$@"
}

# -----------------------------------------------------------------------------
# etc.
# -----------------------------------------------------------------------------

file()
{
  command file -p "$@"
  #             └─ don't touch last-accessed time
}

rename()
{
  command rename --verbose "$@"
}

scp()
{
  command scp -rp "$@"
  #            │└─ preserve times/modes
  #            └── recursive
}

top()
{
  command top -F -R -u -user "$USER" "$@"
  #            │  │  │  └─────────────── only processes owned by current user
  #            │  │  └────────────────── sort by CPU usage and execution time
  #            │  └───────────────────── don't traverse/report memory object map for each process
  #            └──────────────────────── ignore frameworks
}

if [[ $OSTYPE == darwin* ]]; then
  killall() { command killall -v "$@"; }
  #                            └─ verbose
fi
