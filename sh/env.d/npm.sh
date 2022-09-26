if command -v npm >/dev/null; then
  # prevent creation of ~/.config/configstore
  export NO_UPDATE_NOTIFIER=true

  # Remove ad spam during `npm install`
  export OPEN_SOURCE_CONTRIBUTOR=true
fi
