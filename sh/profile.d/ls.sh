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
  [ "$PLATFORM" = "windows" ] && set -- --append-exe "$@"

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

ll()
{ #: - vertical output, info-heavy
  set -- -lh "$@"
  #       │└───── human-readable sizes
  #       └────── long-list output

  # less info on narrower terminals
  if [ $(( COLUMNS < 100 )) = 1 ]; then
    set -- -go "$@"
    #       │└─── omit owner
    #       └──── omit group
    if _isGNU ls; then
      set -- --time-style='+%y-%m-%d %H:%M' "$@" # "${@//--time-style=+%*/}"
    fi
  fi

  ls "$@"
}

# -----------------------------------------------------------------------------

lsf()
{ # "full" info

  set -- -Ail "$@"
  #       ││└──── long-list output
  #       │└───── print inode number
  #       └────── list (almost) all files

  if [ "$PLATFORM" = "mac" ]; then
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
