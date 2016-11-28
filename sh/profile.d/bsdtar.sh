if [ "$PLATFORM" = "windows" ] && [ -x /usr/bin/bsdtar ]; then
  tar () { /usr/bin/bsdtar "$@"; }
fi
