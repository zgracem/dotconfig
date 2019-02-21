_inPath convert || return

palette()
{ #: - creates a colour palette given an image
  #: $ palette <image> [size]
  #: | IMAGE = path to source image
  #: | SIZE  = number of colours in the palette (default: 16)
  #: < ImageMagick

  if (( $# == 0 )); then
    fx_usage >&2
    return 1
  fi

  local image="$1"
  local size="${2-16}"

  local -a colours=()
  mapfile -t colours < <(_z_get_palette "$image" "$size")
  swatches "${colours[@]}"
}

_z_get_palette()
{
  local image="$1"
  local size="$2"

  convert "$image" +dither -colors "$size" \
    -define histogram:unique-colors=true -format "%c" histogram:info: \
  | grep --color=never -o '#[[:xdigit:]]{6}'
}
