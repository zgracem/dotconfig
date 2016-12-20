_inPath dayone || return

d1import()
{
  local entry_file="$1"
  local entry_date

  if [[ -r $entry_file ]]; then
    if entry_date=$(stat --printf=%y "$entry_file"); then
      dayone -d="$entry_date" new < "$entry_file"
    else
      scold "$FUNCNAME: failed to get date from $entry_file"
      return 65
    fi
  else
    scold "$FUNCNAME: failed to read $entry_file"
    return 74
  fi
}
