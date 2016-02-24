[[ $OSTYPE =~ cygwin ]] || return

vnc()
{
  if [[ ! -d $dir_drive ]]; then
    if ! dir_drive=$(findDrive $myDrive); then
      scold "'${myDrive}' not available"
      return 1
    fi
  fi

  local vnc_dir="$dir_drive/bin/RealVNC"

  if [[ -x $vnc_dir/vncviewer.exe ]]; then
    local config_file=$(cygpath -aw "$vnc_dir/vnc.conf")
    run "$vnc_dir/vncviewer.exe" -config "$config_file"
  else
    scold "$vnc_dir/vncviewer.exe not found"
    return 1
  fi
}
