PIP_CONFIG_FILE="$HOME/.local/config/pip.conf"

if [ -f "$PIP_CONFIG_FILE" ] && command -v pip >/dev/null; then
  export PIP_CONFIG_FILE
else
  unset -v PIP_CONFIG_FILE
fi
