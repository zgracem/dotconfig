[[ $OSTYPE == cygwin ]] || return

vnc()
{
  # set `dir_drive` if it's not already
  dir_drive=${dir_drive:-$(find_drive "$myDrive")} || return

  local vnc_dir="$dir_drive/bin/RealVNC"

  if [[ -x $vnc_dir/vncviewer.exe ]]; then
    local config_file=$(cygpath -aw "$vnc_dir/vnc.conf")
    if run "$vnc_dir/vncviewer.exe" -config "$config_file"; then
      dtterm "6t" # lower window
      rollback
    fi
  else
    scold "$vnc_dir/vncviewer.exe not found"
    return 1
  fi
}
