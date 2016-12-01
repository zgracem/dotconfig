WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"

if command -v wget >/dev/null; then
  export WGETRC
else
  unset -v WGETRC
fi
