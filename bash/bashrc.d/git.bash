alias gd='git difftool'

if [[ $OSTYPE =~ cygwin && -x "${dir_apps}/Git/cmd/git" ]]; then
  alias wingit="${dir_apps}/Git/cmd/git"
fi

# symlink config file into HOME
z::config::symlink "git/config" ".gitconfig"
