_inPath uuidgen || return

uuid()
{ #: - generate a UUID and copy it to the clipboard
  local uuid; uuid=$(uuidgen)
  printf '%s' "$uuid" | pbcopy
  echo "$uuid"
}
