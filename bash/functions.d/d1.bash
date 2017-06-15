d1()
{ #: - creates a new Day One entry
  #: < dayone
  _require dayone || return

  # create temp file to hold entry
  local entry
  printf -v entry "$XDG_RUNTIME_DIR/dayone.%(%Y%m%d.%H%M%S)T.md"
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
      return 65
    fi
  else
    scold "editor error"
    return 70
  fi
}
