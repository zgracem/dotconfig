# -----------------------------------------------------------------------------
# use dircolors(1) to set LS_COLORS
# -----------------------------------------------------------------------------

if [[ -z $LS_COLORS || -n $Z_RELOADING ]]; then
  dc_src_dir="$dir_config/dircolors"
  dc_cache_dir="$XDG_CACHE_HOME/dircolors"

  if [[ -n $HV_LOADED ]]; then
    dc_stub="500kv.dircolors"
  elif [[ -n $Z_SOLARIZED ]]; then
    dc_stub="solarized.$Z_SOLARIZED"
  else
    dc_stub="default"
  fi

  dc_src_file="$dc_src_dir/$dc_stub"
  dc_cache_file="$dc_cache_dir/$dc_stub"

  if [[ ! -f $dc_cache_file || $dc_src_file -nt $dc_cache_file || ${FUNCNAME[1]} == "rl" ]] \
      && [[ -f $dc_src_file ]] && _inPath dircolors
  then
    verbose 2 ">> dircolors is recreating $dc_cache_file from $dc_src_file"

    # create cache dir if it doesn't exist
    [[ -d $dc_cache_dir ]] || mkdir -p "$dc_cache_dir" 1>/dev/null

    # create cache file
    dircolors -b "$dc_src_file" >| "$dc_cache_file"
  fi

  if [[ -f $dc_cache_file ]]; then
    # set and export LS_COLORS
    eval "$(<"$dc_cache_file")"
  fi

  unset -v ${!dc_*}
fi
