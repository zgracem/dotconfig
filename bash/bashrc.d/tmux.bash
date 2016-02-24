_inPath tmux || return

tt()
{
    local session=${1:-$(date +%F)}

    tmux new-session -A -s "$session"
    #                 │  └─ session name
    #                 └──── attach if session already exists
}
