killall "iTerm2"
killall "Visual Studio Code"

set -g XDG_CONFIG_HOME ~/.config
set -g XDG_DATA_HOME ~/.local/share
set -g XDG_CACHE_HOME ~/var/cache
set -g XDG_RUNTIME_DIR ~/var/run
set -g XDG_STATE_HOME ~/var/lib

launchctl setenv XDG_CONFIG_HOME $XDG_CONFIG_HOME
launchctl setenv XDG_DATA_HOME $XDG_DATA_HOME
launchctl setenv XDG_CACHE_HOME $XDG_CACHE_HOME
launchctl setenv XDG_RUNTIME_DIR $XDG_RUNTIME_DIR
launchctl setenv XDG_STATE_HOME $XDG_STATE_HOME

mkdir -p "$XDG_RUNTIME_DIR"
and chown "$USER" "$XDG_RUNTIME_DIR"
and chmod 0700 "$XDG_RUNTIME_DIR"

set -g SOLARGRAPH_CACHE $XDG_CACHE_HOME/solargraph/cache
launchctl setenv SOLARGRAPH_CACHE $SOLARGRAPH_CACHE

launchctl setenv Z_ENV (date '+%F %T')
