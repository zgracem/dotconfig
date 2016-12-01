command -v screen >/dev/null || return

export SCREENDIR="$XDG_RUNTIME_DIR"
export SCREENRC="$XDG_CONFIG_HOME/screen/screenrc"

# Solarized Light colour scheme
if [ "$Z_SOLARIZED" = "light" ]; then
  SCREENRC="$dir_config/screen/screenrc.light"
fi
