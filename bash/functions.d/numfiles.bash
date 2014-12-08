numfiles()
{   # return the number of files in $PWD (or $1)
    # Based on: https://github.com/tejr/dotfiles/blob/master/bash/bashrc.d/cf.bash

    local dir="${1-$PWD}" dotglob nullglob
    local -a files

    # check target directory
    if [[ ! -e $dir ]]; then
        scold "$FUNCNAME: $dir: not found"
        return 1
    elif [[ ! -d $dir ]]; then
        scold "$FUNCNAME: $dir: not a directory"
        return 1
    elif [[ ! -r $dir ]]; then
        scold "$FUNCNAME: $dir: not readable"
        return 1
    fi

    # capture glob settings
    _shoptSet dotglob \
        && dotglob=true
    _shoptSet nullglob \
        && nullglob=true

    # populate files array
    shopt -s dotglob nullglob
    files=("$dir"/*)

    # reset options
    [[ $dotglob == true ]] \
        || shopt -u dotglob

    [[ $nullglob == true ]] \
        || shopt -u nullglob

    # print result
    printf '%d\t%s\n' "${#files[@]}" "$dir"
}
