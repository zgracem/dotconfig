howto()
{
    if (( $# == 0 )); then
        cd "$dir_howto"
        return
    elif [[ $1 == -e ]]; then
        local do_edit='true'
        shift
    fi

    local subject="$@"
    local file="${dir_howto}/${subject}.markdown"

    if [[ $do_edit == true ]]; then
        _edit "$file"
        return 0
    elif [[ -f $file ]]; then
        less -F "$file"
    else
        local answer='n'

        printf '%s' "${file/#$HOME/$'~'} does not exist. "
        read -e -p 'Create it? [y/N] ' answer

        if [[ $answer =~ [yY] ]]; then
            _edit "$file"
            return 0
        else
            return 1
        fi
    fi
}
