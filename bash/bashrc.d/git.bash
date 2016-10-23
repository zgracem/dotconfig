# symlink config file into HOME
if [[ -f ~/.local/config/gitconfig ]]; then
  _z_config_symlink ".local/config/gitconfig"
elif [[ -L ~/.gitconfig ]]; then
  rm -fv ~/.gitconfig
fi
