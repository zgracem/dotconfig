# coreutils

cp()
{
    local flags_cp=
    flags_cp+='-i ' # interactive
    flags_cp+='-v ' # verbose
    flags_cp+='-a ' # archive mode (recursive; don't follow symlinks; preserve attributes)

    command cp $flags_cp "$@"
}

ln()
{
    local flags_ln=
    flags_ln+='-v ' # verbose

    command ln $flags_ln "$@"
}

mkdir()
{
    local flags_mkdir
    flags_mkdir+='-p '  # create parents as required
    flags_mkdir+='-v '  # verbose

    command mkdir $flags_mkdir "$@"
}

mv()
{
    local flags_mv=
    flags_mv+='-i ' # interactive
    flags_mv+='-v ' # verbose

    if _isGNU mv && [[ $OSTYPE =~ darwin ]]; then
        # http://brettterpstra.com/2014/07/04/how-to-lose-your-tags/
        /bin/mv $flags_mv "$@"
    else
        command mv $flags_mv "$@"
    fi
}

rm()
{
    local flags_rm=
    flags_rm+='-i ' # interactive
    flags_rm+='-v ' # verbose

    command rm $flags_rm "$@"
}

stat()
{
    local flags_stat=
    flags_stat+='-L'    # follow links

    if ! _isGNU stat; then
        flags_stat+=' -x -t "%F %T"'
    fi

    command stat $flags_stat "$@"
}
