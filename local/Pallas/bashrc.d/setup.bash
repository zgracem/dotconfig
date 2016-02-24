setup()
{
    local cyg_bin="$dir_downloads/_Installers/setup-x86_64.exe"

    local pkg_dir
    pkgdir=$(cygpath -aw "$USERPROFILE/Cygwin")

    local cyg_root
    cyg_root=$(cygpath -aw "/")
    # cyg_root=${cyg_root//\\/\\\\}   # escape backslashes in Windows path

    local -a flags

    flags+=("--local-package-dir \"$pkg_dir\"")
    flags+=("--root \"$cyg_root\"")   # root installation directory
    flags+=("--upgrade-also")       # also upgrade installed packages
    flags+=("--arch x86_64")        # architecture to install (x86_64 or x86)
    flags+=("--no-shortcuts")       # don't create desktop/Start menu shortcuts
    flags+=("--no-verify")          # don't verify setup.ini

    if [[ -x $cyg_bin ]]; then
        run "$cyg_bin" "${flags[@]}"
    else
        scold "can't find $cyg_bin"
        return $EX_UNAVAILABLE
    fi
}
