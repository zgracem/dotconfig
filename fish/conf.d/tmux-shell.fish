# for tmux's default-shell and default-command settings
set -q TMUX; or return
set -q -gx SHELL
or set -gx SHELL (status fish-path 2>/dev/null)
