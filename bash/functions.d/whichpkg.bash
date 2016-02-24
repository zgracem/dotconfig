whichpkg()
{   # find the Cygwin/Homebrew package to which file $1 belongs

    if (( $# == 1 )); then
        local file="$1"
    else
        scold "Usage: $FUNCNAME file"
        return $EX_USAGE
    fi

    local pkg mgr

    if [[ $OSTYPE =~ cygwin ]]; then
        mgr='Cygwin'
        pkg=$(cygcheck --find-package "$file") || return

    elif [[ $OSTYPE =~ darwin ]] && [[ -d $HOMEBREW_CELLAR ]]; then
        mgr='Homebrew'

        local canon

        if canon=$(readlink -e "$file"); then
            local re="^${HOMEBREW_CELLAR}/([^/]+)/([^/]+)/.+\$"

            if [[ $canon =~ $re ]]; then
                pkg="${BASH_REMATCH[1]}-${BASH_REMATCH[2]}"
                file=$canon
            fi
        else
            scold "$file: could not canonicalize"
            return 1
        fi

    else
        scold 'no compatible package manager found'
        return $EX_OSERR
    fi

    if [[ -n $pkg ]]; then
        printf '%s\n' "$pkg"
    else
        scold "$file: does not seem to belong to a $mgr package"
        return 1
    fi
}
