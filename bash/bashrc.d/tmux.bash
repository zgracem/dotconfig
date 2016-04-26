_inPath tmux || return

tt()
{ # attach to an existing tmux session or create a new one
  tmux attach-session 2>&- || tmux new-session
}
