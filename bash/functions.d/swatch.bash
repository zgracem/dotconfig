_inPath convert || return

swatch()
{ #: - create a swatch in PWD of a given colour (and optional size)
  #: $ swatch <colour> [size]
  #: | COLOUR = a hex colour like "#ff33cc" or a named colour like "pink"
  #: | SIZE   = size of the square output swatch in pixels (default: 256)
  #: < ImageMagick

  local colour="$1" size="${2-256}"
  local out_file="swatch_${colour#\#}.png"

  # allow hex COLOURs without a leading `#`
  if [[ $colour =~ ^[[:xdigit:]]{6,8}$ ]]; then
    colour="#${colour}"
  fi

  # allow both `256` and `256x128` as arguments for SIZE
  if [[ $size =~ ^[[:digit:]]+$ ]]; then
    size="${size}x${size}"
  fi

  convert -size "${size}" "canvas:${colour}" "$out_file" \
    && echo "${out_file}"
}

swatches()
{ #: - create a single image in PWD with multiple colour swatches
  #: $ swatches <colour> [colours ...]
  #: | COLOUR = each a hex colour like "#ff33cc" or a named colour like "pink"
  #: < ImageMagick

  local -a colours=("$@")
  local timestamp="${EPOCHREALTIME-$(date +%s.%N)}"
  local out_file="swatches_${timestamp#*.}.png"

  local -a tmp_files=()
  local colour; for colour in "${colours[@]}"; do
    tmp_files+=("$(swatch "${colour}")")
  done

  montage "${tmp_files[@]}" -geometry "+0+0" "${out_file}" && {
    rm -f "${tmp_files[@]}" &>/dev/null
    echo "${out_file}"
  }
}
