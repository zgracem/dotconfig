# Sourced from ~/scripts/util/confsync.sh

syncdir()
{
  if (( $# >= 2 )); then
    local src="${1%/}" # trim trailing slash
    local dst="${2%/}" # trim trailing slash
    shift 2
  else
    printf 'Usage: %s SOURCE [USER@][HOST:]DESTINATION [FLAGS ...]\n' $FUNCNAME >&2
    return 64
  fi

  set -- --exclude=.DS_Store --exclude=.git "$@"

  # recurse, and preserve symlinks, times, permissions [-a]
  # but not group/owner
  set -- --archive --no-group --no-owner "$@"

  # use SSH instead of RSH [-e]
  set -- --rsh=$(type -P ssh) "$@"

  # compress file data during the transfer [-z]
  set -- --compress "$@"

  # find extraneous files during xfer, delete after
  set -- --delete-delay "$@"

  # output numbers in a human-readable format [-h]
  set -- --human-readable "$@"

  # show progress during transfer
  set -- --progress "$@"

  # set -- --verbose "$@" # [-v]
  # set -- --dry-run "$@" # [-n]

  rsync "$@" "$src/" "$dst" \
  | grep -v '/$'
}
