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

    # recurse; preserve symlinks, times, permissions, but not group/owner
    flags+=(--archive --no-group --no-owner)

    # use SSH instead of RSH
    flags+=(--rsh=$(type -P ssh))

    # compress file data during the transfer
    flags+=(--compress)

    # find extraneous files during xfer, delete after
    flags+=(--delete-delay)

    # output numbers in a human-readable format
    flags+=(--human-readable)

    # show progress during transfer
    flags+=(--progress)
    # flags+=(--verbose)
    # flags+=(--dry-run)

    rsync ${flags[*]} ${usrflags[*]} "$src/" "$dst" \
    | grep -v '/$'
}

return # old version below

# syncdir()
# {
#     if (( $# >= 2 )); then
#         local src="${1%/}" # trim trailing slash
#         local dst="${2%/}" # trim trailing slash
#         shift 2

#         (( $# > 0 )) && local -a exclude=("$@")

#         local -a flags=()
#     else
#         printf 'Usage: %s SOURCE [USER@][HOST:]DESTINATION [EXCLUDE ...]\n' $FUNCNAME >&2
#         return 1
#     fi

#     if [[ ! -d $src ]]; then
#         printf '%s: not a directory\n' "$src" >&2
#         return 1
#     fi

#     # recurse; preserve symlinks, times, permissions, but not group/owner
#     flags+=(--archive --no-group --no-owner)

#     # use SSH instead of RSH
#     flags+=(--rsh=$(type -P ssh))

#     # compress file data during the transfer
#     flags+=(--compress)

#     # find extraneous files during xfer, delete after
#     flags+=(--delete-delay)

#     # output numbers in a human-readable format
#     flags+=(--human-readable)

#     # show progress during transfer
#     flags+=(--progress)
#     # flags+=(--verbose)
#     # flags+=(--dry-run)

#     if [[ -n $exclude ]]; then
#         local x; for x in "${exclude[@]}"; do
#             flags+=(--exclude="$x")
#         done
#     fi

#     if [[ -n $include ]]; then
#         local i; for i in "${include[@]}"; do
#             flags+=(--include="$i")
#         done
#     fi

#     rsync ${flags[*]} "$src/" "$dst" \
#     | grep -v '/$'
# }
