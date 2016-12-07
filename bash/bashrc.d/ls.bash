# -----------------------------------------------------------------------------
# default flags
# -----------------------------------------------------------------------------

unalias ls ll 2>/dev/null

ls()
{
  # list (almost) all files
  set -- -Aq "$@"
  #       │└──── print ? instead of nongraphic characters
  #       └───── list (almost) all files

  # append .exe if cygwin magic was needed
  [[ $PLATFORM == windows ]] && set -- --append-exe "$@"

  if _isGNU ls; then
    # display mtime in YYYY-MM-DD HH:MM format
    set -- --time-style='+%Y-%m-%d %H:%M' "$@"
    # colourize output
    set -- --color=auto "$@"
  else
    # colourize output (BSD syntax)
    set -- -G "$@"
  fi

  command ls "$@"
}

# -----------------------------------------------------------------------------
# variants
# -----------------------------------------------------------------------------

ll() { ls -lgoh "$@"; }
#          │││└── human-readable sizes
#          ││└─── omit owner
#          │└──── omit group
#          └───── long-list output

ls1() { ls -1 "$@"; }
#           └──── filenames only

lst() { ll -rt "$@"; }
#           │└─── sort by time
#           └──── reverse sort (i.e. newest files last)

lsd() { ll -d "${1+$1/}"*/; }
#           └──── list subdirectories, not their contents

# -----------------------------------------------------------------------------

lsf()
{ # "full" info

  set -- -Ail "$@"
  #       ││└──── long-list output
  #       │└───── print inode number
  #       └────── list (almost) all files

  if [[ $PLATFORM == mac ]]; then
    set -- -@OG "$@"
    #       ││└── colourize output
    #       │└─── print file flags
    #       └──── display extended attributes

    /bin/ls "$@"
    return
  elif _isGNU ls; then
    set -- --color=auto "$@"
  else #    ├────────── colourize output
    set -- -G "$@"
  fi

  command ls "$@"
}
