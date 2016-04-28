setup()
{
    : ${dir_drive:=$(findDrive $myDrive)}

    local installer_dir="${dir_drive}/bin/cygwin"
    local pkg_dir="${installer_dir}/pkg"

    read -r pkg_dir < <(cygpath -aw "$pkg_dir")

    local cygwin_root
    read -r cyg_root < <(cygpath -aw /)

    local -a flags

    flags+=("--local-package-dir \"${pkg_dir}\"")
    flags+=("--root \"${cyg_root//\\/\\\\}\"")   # root installation directory
    flags+=('--upgrade-also')       # also upgrade installed packages
    flags+=('--arch x86')           # architecture to install (x86_64 or x86)
    flags+=('--no-admin')           # don't require Administrator privileges
    flags+=('--no-shortcuts')       # don't create desktop/Start menu shortcuts
    flags+=('--no-verify')          # don't verify setup.ini

    local cyg_bin="${installer_dir}/cygwin.exe"

    if [[ -x $cyg_bin ]]; then
        run "$cyg_bin" "${flags[@]}"
    else
        scold "can't find ${cyg_bin}"
        return 69
    fi
}
