fwd()
{
  # moves a file, leaving behind a symlink to the new location
  local old=$1
  local new=$2

  local old_full
  old_full=$(readlink -e "$old") || return 4

  if [[ -d $new ]]; then
    new="$new/$(basename "$old")"
  fi

  if mv -v "$old" "$new"; then
    local new_full
    new_full=$(readlink -e "$new") || return 5

    if ln -sv "$new_full" "$old_full"
    then
      return 0      
    else
      scold "$FUNCNAME: failed: $old_full <- $new_full"
      if [[ -e $new ]]; then
        mv -fv "$new" "$1" || return 6
      fi
      return 7
    fi
  fi
}
