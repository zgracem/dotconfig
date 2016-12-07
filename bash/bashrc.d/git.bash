# symlink host-specific config file into HOME
if [[ -f ~/.local/config/git/config ]]; then
  _z_config_symlink ".local/config/git/config" .gitconfig
elif [[ -L ~/.gitconfig ]]; then
  # use general config file in ~/.config/git/config
  rm -fv ~/.gitconfig
fi
