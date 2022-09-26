# -----------------------------------------------------------------------------
# use dircolors(1) to set LS_COLORS
# -----------------------------------------------------------------------------

_inPath dircolors || return

if [[ -z $LS_COLORS || -n $Z_RELOADING ]]; then
  dc_cache="$XDG_CACHE_HOME/dircolors/thirty2k.ls_colors"

  # build new .ls_colors files if needed
  (cd "$XDG_DATA_HOME/dircolors" && make --quiet all)

  # set and export LS_COLORS
  [[ -f $dc_cache ]] && eval "$(<"$dc_cache")"

  unset -v dc_cache dc_stub
fi
