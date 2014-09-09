# ------------------------------------------------------------------------------
# ~zozo/.config/bash/functions/fzf.bash
# ------------------------------------------------------------------------------

_isFunction fzf || return 69

fd()
{   # cd to selected directory

    local dir
    local search="$1"

    dir=$(find -type d -iname "*${search}*" -printf '%P\n' 2>/dev/null \
        | fzf +m)

    cd "$dir"
}

fkill()
{   # find, then kill, a process

    local sigspec="${1:-9}"
    local ps_flags='ef'
    local kill_cmd='builtin kill'

    if [[ $OSTYPE == cygwin ]]; then
        kill_cmd='/bin/kill --signal $sigspec'
        ps_flags+='W' # include Windows processes 
    fi
    
    command ps -ef \
    | sed 1d \
    | fzf -m \
    | awk '{print $2}' \
    | xargs kill -$sigspec
}

ffe()
{   # find and edit a file with fzf (https://github.com/junegunn/fzf)
    local file=$(fzf --query="$@" --select-1 --exit-0)

    if [[ -n $file ]]; then
        _edit "$file"
    fi
}
