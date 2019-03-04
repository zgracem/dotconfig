itunes()
( #: - retrieves high-res album art from the iTunes Store
  #: $ itunes <album_id> [album2_id ...]
  #: | album_id = the number at the end of the album's iTunes Store URL
  #: < itunes-album-art.sh

  local script="$HOME/scripts/util/itunes-album-art.sh"
  local dir="$HOME/Desktop"

  [[ -x $script ]] || return 1

  cd "$dir" || return

  map "$script": "$@"
)
