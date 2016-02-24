_inPath screen || return

# set socket directory
export SCREENDIR="$HOME/tmp/.screens"

# Solarized Light colour scheme
if [[ $solarized == light ]]; then
    export SCREENRC="${dir_config}/screenrc.light"
else
    export SCREENRC="${dir_config}/screenrc"
fi

# -----------------------------------------------------------------------------

ss()
{   # reattach a session; detach/create it first if necessary
    if [[ -n $SCREENDIR && ! -d $SCREENDIR ]]; then
        command mkdir -p -m 700 "$SCREENDIR"
    else
        chmod 700 "$SCREENDIR"
    fi

    command screen -d -R "$@"
    #               │  └─ reattach a session if one exists, otherwise create it
    #               └──── detach existing session if necessary
}
