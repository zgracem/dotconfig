# -----------------------------------------------------------------------------
# use dircolors(1) to set LS_COLORS
# -----------------------------------------------------------------------------

_inPath dircolors || return

if [[ -z $LS_COLORS || -n $Z_RELOADING ]]; then
  if [[ -n $HV_LOADED ]]; then
    dc_stub="thirty2k"
  elif [[ -n $Z_SOLARIZED ]]; then
    dc_stub="solarized_$Z_SOLARIZED"
  else
    dc_stub="default"
  fi

  dc_src="$XDG_CONFIG_HOME/dircolors/$dc_stub.dircolors"
  dc_cache="$XDG_CACHE_HOME/dircolors/$dc_stub.dircolors"

  if [[ -n $Z_RELOADING || ! -f $dc_cache || $dc_src -nt $dc_cache ]] \
    && [[ -f $dc_src ]]
  then
    verbose 2 ">> dircolors is recreating $dc_cache from $dc_src"

    # create cache dir if it doesn't exist
    mkdir -p "${dc_cache%/*}" >/dev/null

    # create cache file
    dircolors -b "$dc_src" >| "$dc_cache"
  fi

  # set and export LS_COLORS
  [[ -f $dc_cache ]] && eval "$(<"$dc_cache")"

  unset -v dc_cache dc_src dc_stub
fi
