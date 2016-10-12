# -----------------------------------------------------------------------------
# image functions
# -----------------------------------------------------------------------------

[[ $OSTYPE =~ darwin ]] || return

getProperty()
{ # wrapper for sips to strip all the non-property output

  if (( $# == 2 )); then
    local property="$1" file="$2"
  else
    scold "Usage: ${FUNCNAME[0]} PROPERTY FILE"
    return 1
  fi

  sips --getProperty "$property" "$file" \
  | sed -nE "s%^[[:space:]]+$property: (.+)\$%\\1%p"
}

maxWidth()
{ # resize image $2 to $1 pixels wide

  if (( $# == 2 )); then
    local new_width="${1}"
    local img_file="${2}"
  else
    scold "Usage: ${FUNCNAME[0]} WIDTH FILE"
    return 1
  fi

  # get current width and height
  local old_width old_height
  old_width=$(getProperty pixelWidth "$img_file")
  old_height=$(getProperty pixelHeight "$img_file")

  if (( old_width > new_width )); then
    # calculate aspect ratio
    local ratio=$(bc -q 2>/dev/null <<< "scale=3;$old_width/$old_height")

    # calculate new height
    local new_height=$(bc -q 2>/dev/null <<< "scale=0;$new_width/$ratio")

    # resize image
    quietly /usr/bin/sips -z $new_height $new_width "$img_file"
  else
    return 0
  fi
}

# -----------------------------------------------------------------------------

dim()
{   # get image dimensions

  if [[ -z $1 ]]; then
    scold "Usage: ${FUNCNAME[0]} file ..."
    return 1
  fi

  local re_file='[[:upper:]]+ image data, '
  local re_sips='pixelWidth: ([[:digit:]]+)[[:space:]]+pixelHeight: ([[:digit:]]+)'
  local re_dims='([[:digit:]]+) x ([[:digit:]]+)'

  local image info width height

  for image in "$@"; do
    info=$(command file -bp "$image" 2>/dev/null)

    if [[ $info =~ $re_file ]]; then
      if [[ $info =~ $re_dims ]]; then
        width=${BASH_REMATCH[1]}
        height=${BASH_REMATCH[2]}
      elif _inPath sips; then
        info=$(command sips -g pixelWidth -g pixelHeight "$1" 2>&1)

        if [[ $info =~ $re_sips ]]; then
          width=${BASH_REMATCH[1]}
          height=${BASH_REMATCH[2]}
        fi
      fi
    else
      scold "${image}: not an image file"
      return 1
    fi

    if [[ -n $width && -n $height ]]; then
      printf '%d \xC3\x97 %d\n' "$width" "$height"
      return 0
    else
      scold "${image}: could not get dimensions"
      return 1
    fi
  done
}
