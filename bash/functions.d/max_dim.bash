max_dim()
{ #: - resize an image to fit within a specified pixel size
  #: $ max_dim <pixels> <file>

  if (( $# != 2 )); then
    fx_usage >&2
    return 64
  fi

  _require sips || return

  local pixels="$1"
  local file="$2"
  local new_file="${file%.*}_${pixels}px.${file##*.}"
  
  # resize image
  sips -Z "$pixels" "$file" --out "$new_file" &>/dev/null
}
