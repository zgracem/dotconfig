# Remove ad spam during `npm install` et al.
export ADBLOCK=true
export OPEN_SOURCE_CONTRIBUTOR=true

if command -v npm >/dev/null; then
  export NODE_PATH="$XDG_DATA_HOME/npm/lib/node_modules:/usr/local/lib/node_modules"
  # prevent creation of ~/.config/configstore by update-notifier module
  export NO_UPDATE_NOTIFIER=true
fi
