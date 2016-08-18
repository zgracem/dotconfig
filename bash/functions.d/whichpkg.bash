whichpkg()
{   # find the Cygwin/Homebrew package to which file $1 belongs

    if (( $# == 1 )); then
        local file="$1"
    else
        scold "Usage: $FUNCNAME file"
        return $EX_USAGE
    fi

    if [[ ! $file =~ / ]]; then
        # If we're not passing a full path, search the current directory, then
        # check PATH for an executable.
        if [[ -f $PWD/$file ]]; then
            file="$PWD/$file"
        elif file=$(type -P "$file"); then
            # Do nothing, we're fine
            :
        else
            scold "not found: $1"
            return $EX_NOINPUT
        fi
    fi

    if [[ $OSTYPE =~ cygwin ]]; then
        local mgr='Cygwin'
        local pkg=$(cygcheck --find-package "$file") || return

    elif [[ $OSTYPE =~ darwin ]] && [[ -d $HOMEBREW_CELLAR ]]; then
        local mgr='Homebrew'

        local canon

        if canon=$(mdutil -t "$file"); then
            local re="^${HOMEBREW_CELLAR}/([^/]+)/([^/]+)/.+\$"

            if [[ $canon =~ $re ]]; then
                local pkg="${BASH_REMATCH[1]}-${BASH_REMATCH[2]}"
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
