# alpine
# >> http://patches.freeiz.com/alpine

alpine()
{
  _require alpine || return

  set -- -i -p "$HOME/.private/alpine/pinerc" "$@"
  #       │  └─ use alternate .pinerc
  #       └──── go directly to index, bypassing main menu

  newwin command alpine "$@"
}
