[[ $OSTYPE == cygwin ]] || return

vnc()
{
  local vnc_conf="$XDG_CONFIG_HOME/vnc/vnc.conf"
  local vnc_dir="$dir_apps/RealVNC"
  local vnc_exe="$vnc_dir/vncviewer.exe"
  local vnc_host="10.0.1.10:1"

  if [[ -x $vnc_exe ]]; then
    vnc_conf=$(cygpath -aw "$vnc_conf")
    if run "$vnc_exe" -config "$vnc_conf"; then
      dtterm "6t" # lower window
      rollback
    else
      return
    fi
  else
    scold "not found: $vnc_exe"
    return 1
  fi
}
