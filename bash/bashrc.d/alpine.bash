# alpine
# http://patches.freeiz.com/alpine

_inPath alpine || return

alpine()
{
    # go directly to index, bypassing main menu
    local flags_alpine='-i'

    # use alternate .pinerc
    flags_alpine+=' -p ${dir_config}/alpine/pinerc'

    # use passfile
    flags_alpine+=' -passfile ${dir_config}/alpine/alpine-passfile'

    if [[ -n $STY || -n $TMUX ]]; then
        newwin alpine $flags_alpine "$@"
    else
        command alpine $flags_alpine "$@"
    fi
}
