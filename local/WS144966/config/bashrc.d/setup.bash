setup()
{
    # set `dir_drive` if it isn't already
    dir_drive=${dir_drive:-$(find_drive "$myDrive")} || return

    local log_dir="/var/log"
    local installer_dir="${dir_drive}/bin/cygwin"
    local cyg_bin="${installer_dir}/cygwin.exe"

    local pkg_dir
    pkg_dir=$(cygpath -aw "${installer_dir}/pkg")

    local cyg_root
    cyg_root=$(cygpath -aw /)

    local -a flags=()

    # root installation directory
    flags+=("--root \"${cyg_root//\\/\\\\}\"")
    
    # where to save downloaded packages
    flags+=("--local-package-dir \"${pkg_dir}\"")

    flags+=("--upgrade-also")       # also upgrade installed packages
    flags+=("--arch x86")           # architecture to install (x86_64 or x86)
    flags+=("--no-admin")           # don't require Administrator privileges
    flags+=("--no-shortcuts")       # don't create desktop/Start menu shortcuts
    flags+=("--no-verify")          # don't verify setup.ini

    if [[ -x $cyg_bin ]]; then
        PWD="$log_dir" run "$cyg_bin" "${flags[@]}"
        # otherwise setup.log will write to actual PWD for some annoying reason
    else
        scold "can't find ${cyg_bin}"
        return 69
    fi
}
