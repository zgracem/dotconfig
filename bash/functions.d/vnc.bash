[[ $OSTYPE == cygwin ]] || return

vnc()
{
  # # set `dir_drive` if it's not already
  # dir_drive=${dir_drive:-$(find_drive "$myDrive")} || return

  local vnc_dir="$dir_apps/RealVNC"
  local vnc_exe="$vnc_dir/vncviewer.exe"
  local vnc_conf="$dir_config/vnc/vnc.conf"
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
