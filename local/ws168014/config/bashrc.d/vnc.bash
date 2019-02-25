[[ $OSTYPE == cygwin ]] || return

vnc()
{
  local vnc_dir="$dir_apps/RealVNC"
  local vnc_exe="$vnc_dir/VNC-Viewer-6.1.0-Windows-32bit.exe"
  local vnc_host="10.0.1.10:1"

  if [[ -x $vnc_exe ]]; then
    if run "$vnc_exe"; then
      _dtterm "6t" # lower window
      rollback
    else
      return
    fi
  else
    scold "not found: $vnc_exe"
    return 1
  fi
}

vnc5()
{
  local vnc_dir="$dir_apps/RealVNC"
  local vnc_exe="$vnc_dir/vncviewer.exe"
  local vnc_host="10.0.1.10:1"
  local vnc_conf="$HOME/.private/vnc/vnc.conf"

  if [[ -x $vnc_exe ]]; then
    vnc_conf=$(cygpath -aw "$vnc_conf")
    if run "$vnc_exe" -config "$vnc_conf"; then
      _dtterm "6t" # lower window
      rollback
    else
      return
    fi
  else
    scold "not found: $vnc_exe"
    return 1
  fi
}
