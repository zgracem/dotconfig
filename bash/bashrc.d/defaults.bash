# -----------------------------------------------------------------------------
# coreutils
# -----------------------------------------------------------------------------

cp()
{
  command cp -aiv "$@"
  #           ││└─ verbose
  #           │└── interactive
  #           └─── archive mode (recursive; don't follow symlinks; preserve attributes)
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
  set -- -iv "$@"
  #       │└─ verbose
  #       └── interactive

  if [[ $PLATFORM == mac ]]; then
    # >> http://brettterpstra.com/2014/07/04/how-to-lose-your-tags/
    /bin/mv "$@"
  else
    command mv "$@"
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
  set -- -a "$@"
  #       └─── show processes from all users

  if [[ $PLATFORM == windows ]]; then
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

# -----------------------------------------------------------------------------
# verbosity
# -----------------------------------------------------------------------------

if _inPath dtrx; then
  dtrx() { command dtrx --verbose "$@"; }
fi

if _inPath rename; then
  rename() { command rename --verbose "$@"; }
fi

if _inPath stow; then
  stow() { command stow --verbose "$@"; }
fi

if [[ $PLATFORM == mac ]]; then
  killall() { command killall -v "$@"; }
  #                            └─ verbose
fi

# -----------------------------------------------------------------------------
# etc.
# -----------------------------------------------------------------------------

file()
{
  command file -p "$@"
  #             └── don't touch last-accessed time
}

scp()
{
  command scp -rp "$@"
  #            │└── preserve times/modes
  #            └─── recursive
}

top()
{
  set -- -F -R -u "$@"
  #       │  │  └── sort by CPU usage and execution time
  #       │  └───── don't traverse/report memory object map for each process
  #       └──────── ignore frameworks

  set -- -user "$USER" "$@"
  #       └──────── only processes owned by current user

  command top "$@"
}

# `-a` scans the whole file instead of using insecure libbfd
# >> https://lcamtuf.blogspot.ca/2014/10/psa-dont-run-strings-on-untrusted-files.html
if _inPath strings; then
  strings() { command strings -a "$@"; }
elif _inPath gstrings; then
  strings() { gstrings -a "$@" ; }
fi
