_inPath convert || _inPath sips || return

max_dim()
{ #: - resize an image to fit within a specified pixel size
  #: $ max_dim <pixels> <file>

  if (( $# != 2 )); then
    fx_usage >&2
    return 1
  fi

  local pixels="$1"
  local file="$2"
  local new_file="${file%.*}_${pixels}px.${file##*.}"
  
  if _inPath convert; then
    convert "$file" -resize "${pixels}x${pixels}" "$new_file"
  elif _inPath sips; then
    sips -Z "$pixels" "$file" --out "$new_file" &>/dev/null
  fi
}
