dataurl()
{ #: - create a data URL from an image
  #: $ dataurl <image>
  #: > https://github.com/mathiasbynens/dotfiles/blob/master/.functions

  if (( $# != 1 )); then
    fdoc_usage >&2
    return 64
  elif [[ ! -f $1 ]]; then
    scold "file not found: $1"
    return 65
  fi

  local img="$1"
  local ext="${img##*.}"
  local b64

  if b64=$(openssl base64 -in "$img" | tr -d '\n'); then
    printf 'data:image/%s;base64,%s\n' "$ext" "$b64"
  fi
}
