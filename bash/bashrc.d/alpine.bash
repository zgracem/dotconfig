# alpine
# http://patches.freeiz.com/alpine

_inPath alpine || return

# Create a write-protected ~/.pinerc so alpine has to use our custom path.
(printf "" >| ~/.pinerc && chmod 400 ~/.pinerc) 2>/dev/null

# Keep homedir tidy.
z_tidy ~/.pine-debug{1..4} ~/.pine-crash

alpine()
{
  local flags_alpine=(-i -p "$dir_config/alpine/pinerc")
  #                    │  └─ use alternate .pinerc
  #                    └──── go directly to index, bypassing main menu

  newwin command alpine ${flags_alpine[*]} "$@"
}
