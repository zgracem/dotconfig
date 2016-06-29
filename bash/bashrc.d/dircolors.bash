# -----------------------------------------------------------------------------
# use dircolors(1) to set LS_COLORS
# -----------------------------------------------------------------------------

if [[ -z $LS_COLORS || -n $Z_RELOADING ]]; then
  dc_src="$dir_config/dircolors"
  dc_cache="$dir_cache/dircolors"

  if [[ -n $Z_SOLARIZED ]]; then
    dc_stub="solarized.$Z_SOLARIZED"
  elif [[ -n $HV_LOADED ]]; then
    dc_stub="500kv.dircolors"
  else
    dc_stub="default"
  fi

  dc_src_file="$dc_src/$dc_stub"
  dc_cache_file="$dc_cache/$dc_stub"

  if [[ ! -f $dc_cache_file ]] \
    && [[ -f $dc_src_file ]] \
    && _inPath dircolors
  then
    # create cache dir if it doesn't exist
    [[ -d $dc_cache ]] || mkdir -p "$dc_cache" 1>/dev/null

    # create cache file
    dircolors -b "$dc_src_file" > "$dc_cache_file"
  fi

  if [[ -f $dc_cache_file ]]; then
    # set and export LS_COLORS
    eval "$(<"$dc_cache_file")"
  fi

  unset -v ${!dc_*}
fi
