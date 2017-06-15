dim()
{ #: - return the dimensions of an image
  #: $ dim <image_file>
  local image="$1"
  local dim_regex='([[:digit:]]+) x ([[:digit:]]+)'

  local info; info=$(file -bp "$image")

  if [[ $info =~ "image data" ]]; then
    local width=0 height=0

    if _inPath sips; then
      width=$(get_property pixelWidth "$image")
      height=$(get_property pixelHeight "$image")
    elif [[ $info =~ '([[:digit:]]+) x ([[:digit:]]+)' ]]; then
      width="${BASH_REMATCH[1]}"
      height="${BASH_REMATCH[2]}"
    fi

    if [[ -n $width && -n $height ]]; then
      printf "%s: %d × %d\n" "$image" "$width" "$height"
    else
      scold "$image: could not get dimensions"
      return 1
    fi
  else
    scold "$image: not an image file"
    return 1
  fi

  return 0
}
