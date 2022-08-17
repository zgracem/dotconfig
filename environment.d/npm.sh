if command -v npm >/dev/null; then
  # prevent creation of ~/.config/configstore
  export NO_UPDATE_NOTIFIER=true
fi
