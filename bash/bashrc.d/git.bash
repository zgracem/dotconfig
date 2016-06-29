alias gd='git difftool'

if [[ $OSTYPE =~ cygwin && -x "${dir_apps}/Git/cmd/git" ]]; then
  alias wingit="${dir_apps}/Git/cmd/git"
fi

# symlink config file into HOME
_z_config_symlink "git/config" ".gitconfig"
