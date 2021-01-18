command -sq pip; or exit

# Can't use environment variables like $HOME in pip.conf
set -gx PIP_CACHE_DIR $HOME/var/cache/pip
set -gx PIP_LOG $HOME/var/log/pip/pip.log
