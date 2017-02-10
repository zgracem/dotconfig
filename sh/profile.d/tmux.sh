tt()
{ #: -- attaches to existing session tmux (if any); otherwise creates one
  # Unfortunately, just calling `tmux attach || tmux new` causes a segfault if
  # there's no existing session.
  tmux new-session -A -s "${1-main}"
  #                 │  └─ session name
  #                 └──── attach if session already exists
}
