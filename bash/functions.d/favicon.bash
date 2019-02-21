_inPath convert || return

favicon()
{ #: - create a multi-size favicon.ico from a single PNG file
  #: $ favicon [img [ico]]
  #: | img = a 256 × 256 PNG file (default: ./favicon.png)
  #: | ico = the output icon file (default: ./favicon.ico)
  #: < ImageMagick
  local img="${1:-favicon.png}"
  local out_file="${2:-favicon.ico}"

  if [[ $img != *.png ]]; then
    scold "$img: not a .png file!"
    return 1
  fi

  local -a imgs=()
  local size; for size in 16 32 48 128; do
    local size_img="favicon_${size}.png"
    convert "$img" -resize "$size" "$size_img" >/dev/null || return
    imgs+=("$size_img")
  done

  convert "${imgs[@]}" "$img" "$out_file" || return

  rm -f "${imgs[@]}" >/dev/null
}
