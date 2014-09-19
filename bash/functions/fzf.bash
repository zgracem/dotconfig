# ------------------------------------------------------------------------------
# ~zozo/.config/bash/functions/fzf.bash
# ------------------------------------------------------------------------------

_isFunction fzf || return 69

fcd()
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
    local target_pid

    local ps_flags='ef'
    local kill_cmd="builtin kill -${sigspec}"

    if [[ $OSTYPE == cygwin ]]; then
        ps_flags+='W' # include Windows processes
        kill_cmd="/bin/kill --force --signal ${sigspec}"
    fi

    target_pid=$(
        command ps -$ps_flags \
        | sed 1d \
        | fzf -m \
        | awk '{print $2}'
    )

    if [[ -n $target_pid ]]; then
        $kill_cmd $target_pid
    fi
}

ffe()
{   # find and edit a file with fzf (https://github.com/junegunn/fzf)
    local file=$(fzf --query="$@" --select-1 --exit-0)

    if [[ -n $file ]]; then
        _edit "$file"
    fi
}
