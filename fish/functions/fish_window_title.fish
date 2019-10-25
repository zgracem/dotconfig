function fish_window_title --description 'Update the window title'
  set -q long_hostname
  or set -g long_hostname (/bin/hostname -f 2>/dev/null)
  or set -g long_hostname $hostname

  printf "%s@%s: %s" $USER $long_hostname (short_home "$PWD")
end
