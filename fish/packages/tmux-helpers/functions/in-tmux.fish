function in-tmux --description 'Exits 0 if currently in an active tmux session'
    # When a new session is created, tmux sets the environment variable TMUX to
    # "<socket>,<pid>,<session>". So we strip everything after (and including)
    # the first comma and test whether the resulting path is indeed a socket.
    set -l tmux_socket (string split -f1 "," "$TMUX")
    and test -S "$tmux_socket"
end
