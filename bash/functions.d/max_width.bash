_inPath convert || _inPath sips || return

max_width()
{ #: - resize an image to a maximum number of pixels wide
  #: $ max_width <pixels> <file>

  if (( $# != 2 )); then
    fx_usage >&2
    return 64
  fi

  local new_width="$1"
  local file="$2"
  local new_file="${file%.*}_${new_width}px.${file##*.}"
  local old_width="" old_height="" ratio="" new_height=""

  if _inPath convert; then
    convert "$file" -resize "$new_width" "$new_file"
  elif _inPath sips; then
    # get current width and height
    old_width=$(get_property pixelWidth "$file")
    old_height=$(get_property pixelHeight "$file")

    # calculate aspect ratio
    ratio=$(bc -q 2>/dev/null <<< "scale=3;$old_width/$old_height")

    # calculate new height
    new_height=$(bc -q 2>/dev/null <<< "scale=0;$new_width/$ratio")

    # resize image
    sips -z "$new_height" "$new_width" "$file" --out "$new_file" &>/dev/null
  fi
}
