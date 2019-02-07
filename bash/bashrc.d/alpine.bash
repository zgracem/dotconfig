# alpine
# >> http://patches.freeiz.com/alpine

_inPath alpine || return

alpine()
{
  set -- -i -p "$HOME/.private/alpine/pinerc" "$@"
  #       │  └─ use alternate .pinerc
  #       └──── go directly to index, bypassing main menu

  newwin command alpine "$@"
}
