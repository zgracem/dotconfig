command -v screen >/dev/null || return

export SCREENDIR="$XDG_RUNTIME_DIR/screen"
export SCREENRC="$XDG_CONFIG_HOME/screen/screenrc"
