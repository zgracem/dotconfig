_inPath convert || return

swatch()
{ #: - create a swatch in PWD of a given colour (and optional size)
  #: $ swatch <colour> [size]
  #: | COLOUR = a hex colour like "#ff33cc" or a named colour like "pink"
  #: | SIZE   = size of the square output swatch in pixels (default: 256)
  #: < ImageMagick

  local colour="$1" size="${2-256}"
  local out_file="${3-swatch_${colour#$'#'}.png}"

  # allow hex COLOURs without a leading `#`
  if [[ $colour =~ ^[[:xdigit:]]{6,8}$ ]]; then
    colour="#${colour}"
  fi

  convert -size "${size}x${size}" "canvas:${colour}" "$out_file" \
    && echo "$out_file"
}

_inPath parallel || return

swatches()
{ #: - create a single image in PWD with multiple colour swatches
  #: $ swatches <colour> [colours ...]
  #: | COLOUR = each a hex colour like "#ff33cc" or a named colour like "pink"
  #: < ImageMagick

  local -a colours=("$@")
  # use nanoseconds for timestamp so this can run in parallel
  local timestamp="${EPOCHREALTIME-$(date +%s.%N)}"; timestamp=${timestamp#*.}
  local out_file="swatches_${timestamp}.png"

  local -a tmp_files=()
  mapfile -t tmp_files < <(_z_make_swatches "${colours[@]}")
  montage "${tmp_files[@]}" -geometry "+0+0" "$out_file" || return

  rm -f "${tmp_files[@]}" &>/dev/null
  echo "$out_file"
}

_z_make_swatches()
( 
  export -f swatch
  # for parallel, but not for everyone (hence the subshell)
  parallel -k swatch {} 128 .swatch_{}.png ::: "$@"
)
