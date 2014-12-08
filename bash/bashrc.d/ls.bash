# default flags

export flags_ls=
flags_ls+='-A '             # (almost) all files
flags_ls+='-p '             # append / to directories

ls()
{
    command ls $flags_ls "$@"
}

# -----------------------------------------------------------------------------
# colours
# -----------------------------------------------------------------------------

colour_dir="$HOME/share/dircolors"

if [[ -d $colour_dir ]] && _inPath dircolors; then
    if [[ -n $solarized ]]; then
        colour_file="$colour_dir/solarized.$solarized"
    else
        colour_file="$colour_dir/default"
    fi

    # sets and exports LS_COLORS
    eval $(dircolors -b $colour_file)
fi

unset -v colour_dir colour_file

if _isGNU ls; then
    flags_ls+=' --color=auto'
else
    # http://geoff.greer.fm/lscolors/
    export LSCOLORS="exfxdacabxgagaabadHbHd"
    export CLICOLOR=1
fi
