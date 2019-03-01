tt()
{ #: -- attaches to existing tmux session (if any); otherwise creates one
  tmux attach 2>/dev/null || tmux new "$@"
}
