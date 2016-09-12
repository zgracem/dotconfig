_inPath tmux || return

if (( MACOS_VERSINFO[0] >= 12 )); then
  # kqueue is broken on macOS, but tmux 2.2 doesn't turn it off like it should.
  # >> github.com/tmux/tmux/issues/475
  export EVENT_NOKQUEUE=1
fi

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
_z_config_symlink "tmux/tmux.conf"
