# -----------------------------------------------------------------------------
# use dircolors(1) to set LS_COLORS
# -----------------------------------------------------------------------------

_inPath dircolors || return

if [[ -z $LS_COLORS || -n $Z_RELOADING ]]; then
  if [[ -n $HV_LOADED ]]; then
    dc_stub="thirty2k"
  else
    dc_stub="default"
  fi

  dc_cache="$XDG_CACHE_HOME/dircolors/$dc_stub.ls_colors"

  # build new .ls_colors files if needed
  (cd "$XDG_CONFIG_HOME/dircolors" && make --quiet all)

  # set and export LS_COLORS
  [[ -f $dc_cache ]] && eval "$(<"$dc_cache")"

  unset -v dc_cache dc_stub
fi
