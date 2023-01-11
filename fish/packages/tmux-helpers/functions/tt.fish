function tt --wraps tmux --description 'Open tmux'
    tmux attach 2>/dev/null
    or tmux $argv
end
