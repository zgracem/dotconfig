scratch()
{   # create a temporary directory and change into it
    # Based on: https://github.com/tejr/dotfiles/blob/master/bash/bashrc.d/scr.bash

    local dir
    local template="${1:-scratch}"

    if _isGNU mktemp; then
        template+='.XXXXXXXX'
    fi

    dir="$(mktemp -d -t ${template})" || return $EX_OSERR

    if [[ -d $dir ]]; then
        cd "$dir"
    else
        return $EX_CANTCREAT
    fi
}
