# don't use system tmux (it's broken)

if [[ $(type -P tmux) == "/usr/bin/tmux" ]]; then
  unset -f tt
  tt() { screen -d -R "$@"; }
fi
