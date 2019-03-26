# You can't use environment variables like $HOME in pip.conf
if command -v pip >/dev/null; then
  export PIP_CACHE_DIR=$HOME/var/cache/pip
  export PIP_LOG=$HOME/var/log/pip/pip.log
fi
