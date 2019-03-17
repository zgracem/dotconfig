function tt --wraps 'tmux new' --description 'Open tmux'
  tmux attach 2>/dev/null; or tmux new $argv
end
