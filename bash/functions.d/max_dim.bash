max_dim()
{ #: - resize an image to fit within a specified pixel size
  #: $ max_dim <pixels> <file>

  if (( $# != 2 )); then
    fx_usage >&2
    return 64
  fi

  _require sips || return

  local new_size="$1"
  local file="$2"
  local new_file="${file%.*}_${new_size}px.${file##*.}"
  
  # resize image
  sips -Z "$new_size" "$file" --out "$new_file" &>/dev/null
}
