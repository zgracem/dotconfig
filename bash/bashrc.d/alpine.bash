# alpine
# >> http://patches.freeiz.com/alpine

_inPath alpine || return

# Create a write-protected ~/.pinerc so alpine has to use our custom path.
(printf "" >| ~/.pinerc && chmod 400 ~/.pinerc) 2>/dev/null

# -----------------------------------------------------------------------------

alpine()
{
  set -- -i -p "$XDG_CONFIG_HOME/alpine/pinerc" "$@"
  #       │  └─ use alternate .pinerc
  #       └──── go directly to index, bypassing main menu

  newwin command alpine "$@"
}
