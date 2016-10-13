# -----------------------------------------------------------------------------
# default flags
# -----------------------------------------------------------------------------

quietly unalias ls ll

export flags_ls=()

flags_ls+=(-A)
#           └────── (almost) all files

if [[ $OSTYPE == cygwin ]]; then
    flags_ls+=(--append-exe)
    #            └─ append .exe if cygwin magic was needed
fi

# colourize output
if _isGNU ls; then
    flags_ls+=(--color=auto)
else
    flags_ls+=(-G)
fi

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

lsd()
{   # list all subdirectories in $1/$PWD

    ll -d "${1+$1/}"*/
    #   └─── list directories, not their contents
}

lsl()
{   # list all symbolic links in $1/$PWD
    find "${1-.}" -maxdepth 1 -type l \
    | xargs ls -d "${flags_ls}"
}

# -----------------------------------------------------------------------------

lsf()
{   # "full" info

    local a flags_lsf=(-i -l)
    #                    │  └─ long-list output
    #                    └──── print inode number

    if [[ $OSTYPE == darwin* ]]; then
        flags_lsf+=(-@ -O -G)
        #            │  │  └── colourize output
        #            │  └───── print file flags
        #            └──────── display extended attributes

        /bin/ls "${flags_lsf[@]}" "$@"
        return

    elif _isGNU ls; then
        flags_lsf+=(--color=auto)
        #             └─────── colourize output
    else
        flags_lsf+=(-G)
        #            └──────── colourize output
    fi

    command ls "${flags_lsf[@]}" "$@"
}

