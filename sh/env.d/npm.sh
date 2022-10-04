# Remove ad spam during `npm install` et al.
export ADBLOCK=true
export OPEN_SOURCE_CONTRIBUTOR=true

if command -v npm >/dev/null; then
  # prevent creation of ~/.config/configstore by update-notifier module
  export NO_UPDATE_NOTIFIER=true
fi
