# alpine
# http://patches.freeiz.com/alpine

_inPath alpine || return

# Create a write-protected ~/.pinerc so alpine has to use our custom path.
printf "" >| ~/.pinerc && 400 ~/.pinerc

export flags_alpine=()

# go directly to index, bypassing main menu
flags_alpine+=("-i")

# use alternate .pinerc
flags_alpine+=("-p ${dir_config}/alpine/pinerc")

# use passfile
flags_alpine+=("-passfile ${dir_config}/alpine/alpine-passfile")

alpine()
{
    if [[ ${FUNCNAME[1]} == okalpine ]]; then
        local extra_flags='--title alpine(ok)'
    fi

    if _mux; then
        newwin ${extra_flags} alpine ${flags_alpine[*]} "$@"
    else
        command alpine ${flags_alpine[*]} "$@"
    fi
}

okalpine()
{
    local flags_alpine=("${flags_alpine[@]/alpine-passfile/alpine-passfile.ok}")
    flags_alpine+=("-x ${dir_config}/alpine/pinerc.ok")

    alpine "$@"
}
