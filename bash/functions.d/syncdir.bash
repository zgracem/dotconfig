syncdir()
{
    if (( $# >= 2 )); then
        local src="${1%/}" # trim trailing slash
        local dst="${2%/}" # trim trailing slash
        shift 2
    else
        printf 'Usage: %s SOURCE [USER@][HOST:]DESTINATION [FLAGS ...]\n' $FUNCNAME >&2
        return 1
    fi

    local -a flags=()
    local -a usrflags=("$@")

    # recurse, and preserve symlinks, times, permissions [-a]
    # but not group/owner
    flags+=(--archive --no-group --no-owner)

    # use SSH instead of RSH [-e]
    flags+=(--rsh=$(type -P ssh))

    # compress file data during the transfer [-z]
    flags+=(--compress)

    # find extraneous files during xfer, delete after
    flags+=(--delete-delay)

    # output numbers in a human-readable format [-h]
    flags+=(--human-readable)

    # show progress during transfer
    flags+=(--progress)
    # flags+=(--verbose) # [-v]
    # flags+=(--dry-run) # [-n]

    rsync ${flags[*]} ${usrflags[*]} "$src/" "$dst" \
    | grep -v '/$'
}
