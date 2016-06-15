_inPath tmux || return

tt()
{ 
  # All we want to do is attach to an existing session (if any), and otherwise
  # create one. Unfortunately, simply calling `tmux attach || tmux new` causes
  # a segfault and core dump if there's no existing session.

  local session=${1:-main}

  tmux new-session -A -s "$session"
  #                 │  └─ session name
  #                 └──── attach if session already exists
}

# symlink config file into HOME
z::config::symlink "tmux/tmux.conf"
