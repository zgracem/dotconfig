_inPath dayone || return

dayone()
{ # because the CLI tool can't find v2's journal file by default
  set -- -j="$HOME/Library/Group Containers/5U8NS4GX82.dayoneapp2/Data/Auto Import/Default Journal.dayone" "$@"
  command dayone "$@"
}
