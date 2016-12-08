tt()
{ # Attach to an existing session (if any), and otherwise create one.
  # Unfortunately, just calling `tmux attach || tmux new` causes a segfault and
  # core dump if there's no existing session.
  tmux new-session -A -s "${1:-main}"
  #                 │  └─ session name
  #                 └──── attach if session already exists
}
