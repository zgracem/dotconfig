command -v screen >/dev/null || return

# set socket directory
export SCREENDIR="$XDG_RUNTIME_DIR"

# keep homedir tidy
export SCREENRC="$XDG_CONFIG_HOME/screen/screenrc"
z_tidy ~/.screen
