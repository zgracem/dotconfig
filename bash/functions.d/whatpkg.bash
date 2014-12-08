[[ $OSTYPE =~ cygwin ]] || return

whatpkg()
{   # find the Cygwin package to which $1 belongs

    declare file="$1" package error

    if [[ ! -f $file ]]; then
        file="$(getPath "$file")" || {
            scold "$1: not found"
            return 1
        }
    fi

    package="$(cygcheck --find-package "$file")"

    if [[ -n $package ]]; then
        echo "$package"
    else
        scold "$file: does not seem to belong to a Cygwin package"
    fi
}
