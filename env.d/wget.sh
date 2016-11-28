command -v wget >/dev/null || return

# Keep homedir tidy.
export WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"
