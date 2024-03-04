# -----------------------------------------------------------------------------
# use dircolors(1) to set LS_COLORS
# -----------------------------------------------------------------------------

type -P dircolors >/dev/null || return

if [[ -z $LS_COLORS || -n $Z_RELOADING ]]; then
  dc_cache="$XDG_DATA_HOME/dircolors/thirty2k.ls_colors"

  # build new .ls_colors files if needed
  make -s -C "$XDG_CONFIG_HOME/dircolors"

  # set and export LS_COLORS
  [[ -f $dc_cache ]] && eval "$(<"$dc_cache")"

  unset -v dc_cache dc_stub
fi
