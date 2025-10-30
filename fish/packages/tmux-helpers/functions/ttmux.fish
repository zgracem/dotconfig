function ttmux --wraps tmux --description 'Open tmux'
    tmux new-session -A $argv
end
