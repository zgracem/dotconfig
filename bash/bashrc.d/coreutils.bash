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

rm()
{
    command rm -iv "$@"
    #           │└─ verbose
    #           └─── interactive
}

# -----------------------------------------------------------------------------
# mv
# -----------------------------------------------------------------------------

export flags_mv=()
flags_mv+=(-i) # interactive
flags_mv+=(-v) # verbose

if [[ $OSTYPE =~ darwin ]] && _isGNU mv; then
    # http://brettterpstra.com/2014/07/04/how-to-lose-your-tags/
    mv()
    {
        /bin/mv "${flags_mv[@]}" "$@"
    }
else
    mv()
    {
        command mv "${flags_mv[@]}" "$@"
    }
fi
    
# -----------------------------------------------------------------------------
# stat
# -----------------------------------------------------------------------------

stat()
{
    local -a flags_stat=(-L)       # follow links

    if ! _isGNU stat; then
        flags_stat+=(-x)           # verbose output
        flags_stat+=('-t "%F %T"') # time format
    fi

    command stat "${flags_stat[@]}" "$@"
}
