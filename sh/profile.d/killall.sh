if [ "$PLATFORM" = "mac" ]; then
  killall() { command killall -v "$@"; }
  #                            └─ verbose
fi
