_inPath convert || return

palette()
{ #: - creates a colour palette given an image
  #: $ palette <image> [size]
  #: | IMAGE = path to source image
  #: | SIZE  = number of colours in the palette (default: 16)
  #: < ImageMagick
  
  local image="$1"
  local size="${2-16}"

  local -a colours=()
  mapfile -t colours < <(
    convert "$image" +dither -colors "$size" \
      -define histogram:unique-colors=true -format "%c" histogram:info: \
    | sort -r \
    | grep -o '#[[:xdigit:]]{6}'
  )

  swatches "${colours[@]}"
}
