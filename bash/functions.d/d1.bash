_inPath dayone || return

dayone()
{
  # because the CLI tool can't find v2's journal file by default
  local journal="$HOME/Library/Group Containers/5U8NS4GX82.dayoneapp2/Data/Auto Import/Default Journal.dayone"
  /usr/local/bin/dayone -j="$journal" "$@"
}

d1()
{
  # create temp file to hold entry
  local entry
  printf -v entry "$HOME/var/tmp/dayone.%(%Y%m%d.%H%M%S)T.md"
  # entry=$(mktemp -q -t "dayone.XXXXXX.md")

  # invoke editor to create entry -- if it exits successfully and creates
  # a file > 0 bytes, send that file to Day One
  if "$VISUAL" "$entry"; then
    if [[ -s $entry ]]; then
      # pass through any arguments to this function, and delete the entry file
      # if it successfully imports
      if dayone new "$@" < "$entry"; then
        /bin/mv "$entry" ~/.Trash >/dev/null \
          && echo "Deleted   : ${entry/#$HOME/$'~'}"
      fi
    else
      scold "zero-length file: $entry"
      return 1
    fi
  else
    scold "editor error"
    return 1
  fi
}

d1import()
{
  local entry_file="$1"
  local entry_date

  if [[ -r $entry_file ]]; then
    if entry_date=$(stat --printf=%y "$entry_file"); then
      dayone -d="$entry_date" new < "$entry_file"
    else
      scold "$FUNCNAME: failed to get date from $entry_file"
      return 1
    fi
  else
    scold "$FUNCNAME: failed to read $entry_file"
    return 1
  fi
}
