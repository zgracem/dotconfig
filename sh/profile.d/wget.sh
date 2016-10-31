command -v wget >/dev/null || return

# Keep homedir tidy.
z_tidy ~/.wgetrc
export WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"
