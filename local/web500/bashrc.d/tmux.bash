# don't use system tmux (it's broken)

if [[ ! -x $HOME/opt/bin/tmux ]]; then
    tt() { screen -d -R "$@"; }
fi
