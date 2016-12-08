command -v screen >/dev/null || return

export SCREENDIR="$XDG_RUNTIME_DIR/screen"
export SCREENRC="$XDG_CONFIG_HOME/screen/screenrc"

# Solarized Light colour scheme
if [ "$Z_SOLARIZED" = "light" ]; then
  SCREENRC="$XDG_CONFIG_HOME/screen/screenrc.light"
fi
