setup()
{
  # Set path to USB drive if it isn't set already.
  dir_drive=${dir_drive:-$(find_drive "$myDrive")} || return

  local installer_dir="$dir_drive/bin/cygwin"
  local cyg_bin="${installer_dir}/cygwin.exe"
  local log_dir="/var/log"

  # Where to save downloaded packages (Windows-style path).
  local pkg_dir
  pkg_dir=$(cygpath -aw "$installer_dir/pkg")

  # Windows-style path to cygwin's root installation directory.
  local cyg_root
  cyg_root=$(cygpath -aw "/")

  local -a flags=()

  # Root installation directory (--root)
  flags+=(-R "${cyg_root//\\/\\\\}")

  # Directory to save downloaded packages in (--local-package-dir)
  flags+=(-l "${pkg_dir}")

  # More options:
  flags+=(-gnXBM -a x86)
  #        │││││  └── Architecture to install: x86_64 or x86 (--arch)
  #        ││││└───── Semi-attended mode (--package-manager)
  #        │││└────── Don't require admin privileges (--no-admin)
  #        ││└─────── Don't verify setup.ini signatures (--no-verify)
  #        │└──────── Don't make desktop/Start menu shortcuts (--no-shortcuts)
  #        └───────── Also upgrade installed packages (--upgrade-also)

  if [[ ! -x $cyg_bin ]]; then
    scold "can't find ${cyg_bin}"
    return 1
  elif ! mkdir -p "$log_dir"; then
    scold "can't create $log_dir"
    return 1
  else
    # Otherwise setup.log will write to actual PWD for some annoying reason.
    (cd "$log_dir" && run "$cyg_bin" "${flags[@]}" "$@")
  fi
}

# To duplicate installation on another computer:
#   setup.exe ... --local-install --quiet-mode --local-package-dir "$pkg_dir"
