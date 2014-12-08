ll()
{
    local flags_ll
    flags_ll+='-l '     # long output
    flags_ll+='-go '    # omit group & owner
    flags_ll+='-h '     # human sizes

    ls $flags_ll "$@"
}

lst()
{   # newest files last
    local flags_lst='-rt'

    ll $flags_lst "$@"
}

ls1()
{   # just the filenames
    command ls -A1 "$@"
}

lsf()
{   # "full" info

    local flags='lAip'
    local colour_flag=' --color=auto'

    if [[ $OSTYPE =~ darwin ]]; then
        flags+='@O'
        colour_flag='G'
    fi

    command -p ls -$flags$colour_flag "$@"
}

lsd()
{   # list all subdirectories in $1/$PWD
    find "${1-.}" -maxdepth 1 -type d \
    | xargs ls -d ${flags_ls}
}

lsl()
{   # list all symbolic links in $1/$PWD
    find "${1-.}" -maxdepth 1 -type l \
    | xargs ls ${flags_ls}
}

lsx()
{   # list all files in $PWD or $2 that match *.$1
    local extension="$1"
    local scope="${2-.}"

    find "$scope" -maxdepth 1 -type f -iname '*.'${extension}'' \
    | xargs ls ${flags_ls}
}

