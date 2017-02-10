fwd()
{ #: - moves a file, leaving behind a symlink to the new location
  #: $ fwd <source> <destination>
  local src=$1
  local dst=$2

  if (( $# != 2 )); then
    fx_usage >&2
    return 64
  fi

  local src_full
  src_full=$(readlink -e "$src") || return 204

  if [[ -d $dst ]]; then
    dst="$dst/$(basename "$src")"
  fi

  if mv -v "$src" "$dst"; then
    local dst_full
    dst_full=$(readlink -e "$dst") || return 205

    if ln -sv "$dst_full" "$src_full"
    then
      return 0      
    else
      scold "$FUNCNAME: failed: $src_full <- $dst_full"
      if [[ -e $dst ]]; then
        mv -fv "$dst" "$1" || return 206
      fi
      return 207
    fi
  fi
}
