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
    local -a flags_mv=(-iv)
    #                   │└─ verbose
    #                   └── interactive

    if [[ $OSTYPE =~ darwin ]]; then
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

stat()
{
    local -a flags_stat=(-L)       # follow links

    if ! _isGNU stat; then
        flags_stat+=(-x)           # verbose output
        flags_stat+=('-t "%F %T"') # time format
    fi

    command stat "${flags_stat[@]}" "$@"
}
