# alpine
# http://patches.freeiz.com/alpine

_inPath alpine || return

# Create a write-protected ~/.pinerc so alpine has to use our custom path.
(printf "" >| ~/.pinerc && chmod 400 ~/.pinerc) 2>/dev/null

alpine()
{
  local flags_alpine=(-i -p "$dir_config/alpine/pinerc")
  #                    │  └─ use alternate .pinerc
  #                    └──── go directly to index, bypassing main menu

  newwin alpine ${flags_alpine[*]} "$@"
}
