[[ $OSTYPE =~ darwin ]] || return

lockfile()
{
    local -a files=("$@")
    local file

    for file in "${files[@]}"; do
        sudo chflags uchg "$file"
        chmod a-w "$file"
    done
}

unlockfile()
{
    local -a files=("$@")
    local file

    for file in "${files[@]}"; do
        sudo chflags nouchg "$file"
        chmod u+w "$file"
    done
}
