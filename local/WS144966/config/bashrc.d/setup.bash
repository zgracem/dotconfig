setup()
{
  # Set path to USB drive if it isn't set already.
  dir_drive=${dir_drive:-$(find_drive "$myDrive")} || return

  local installer_dir="$dir_drive/bin/cygwin"
  local cyg_bin="${installer_dir}/cygwin.exe"
  local log_dir="$HOME/var/log/cygwin"

  # Where to save downloaded packages (Windows-style path).
  local pkg_dir
  pkg_dir=$(cygpath -aw "$installer_dir/pkg")

  # Windows-style path to cygwin's root installation directory.
  local cyg_root
  cyg_root=$(cygpath -aw "/")

  # Root installation directory (-R)
  set -- --root "${cyg_root//\\/\\\\}" "$@"
  # Directory to save downloaded packages in (-l)
  set -- --local-package-dir "${pkg_dir}" "$@"
  # Architecture to install: x86_64 or x86
  set -- --arch x86 "$@"
  # Semi-attended mode
  set -- --package-manager "$@"
  # Also upgrade installed packages
  set -- --upgrade-also "$@"
  # Don't verify setup.ini signature
  set -- --no-verify "$@"
  # Don't create Desktop/Start menu shortcuts (-n)
  set -- --no-shortcuts "$@"
  # Don't require admin privileges
  set -- --no-admin "$@"

  if [[ ! -x $cyg_bin ]]; then
    scold "can't find ${cyg_bin}"
    return 66
  elif ! mkdir -p "$log_dir"; then
    scold "can't create $log_dir"
    return 73
  else
    # Otherwise setup.log will write to actual PWD for some annoying reason.
    (cd "$log_dir" && run "$cyg_bin" "$@")
  fi
}

# To duplicate installation on another computer:
#   setup.exe ... --local-install --quiet-mode --local-package-dir "$pkg_dir"
