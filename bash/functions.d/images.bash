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
    return $EX_USAGE
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
    return $EX_USAGE
  fi

  # get current width and height
  local old_width old_height
  old_width=$(getProperty pixelWidth "$img_file")
  old_height=$(getProperty pixelHeight "$img_file")

  if (( old_width > new_width )); then
    # calculate aspect ratio
    local ratio=$(calc "scale=3;$old_width/$old_height")

    # calculate new height
    local new_height=$(calc "scale=0;$new_width/$ratio")

    # resize image
    quietly /usr/bin/sips -z $new_height $new_width "$img_file"
  else
    return 0
  fi
}
