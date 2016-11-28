# -----------------------------------------------------------------------------
# default flags
# -----------------------------------------------------------------------------

unalias ls ll 2>/dev/null

flags_ls=(-A)
#          └───── list (almost) all files

if [[ $PLATFORM == windows ]]; then
  flags_ls+=(--append-exe)
  #            └─ append .exe if cygwin magic was needed
fi

# colourize output
if _isGNU ls; then
  flags_ls+=(--color=auto)
else
  flags_ls+=(-G)
fi

export flags_ls

ls() { command ls "${flags_ls[@]}" "$@"; }

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

lsl()
{ # list all symbolic links in $1/$PWD
  find "${1-.}" -maxdepth 1 -type l \
  | xargs ls -d "${flags_ls[@]}"
}

# -----------------------------------------------------------------------------

lsf()
{ # "full" info

  local -a flags_lsf=(-i -l)
  #                    │  └─ long-list output
  #                    └──── print inode number

  if [[ $PLATFORM == mac ]]; then
    flags_lsf+=(-@ -O -G)
    #            │  │  └──── colourize output
    #            │  └─────── print file flags
    #            └────────── display extended attributes
    /bin/ls "${flags_lsf[@]}" "$@"
    return
  elif _isGNU ls; then
    flags_lsf+=(--color=auto)
  else #         ├────────── colourize output
    flags_lsf+=(-G)
  fi

  command ls "${flags_lsf[@]}" "$@"
}
