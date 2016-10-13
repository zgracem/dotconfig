# symlink config file into HOME
if [[ -f ~/.local/config/gitconfig ]]; then
  _z_config_symlink ".local/config/gitconfig"
else
  _z_config_symlink "git/config" ".gitconfig"
fi
