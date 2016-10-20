# wego
# https://github.com/schachmat/wego

command -v wego >/dev/null || return

export WEGORC="$XDG_CONFIG_HOME/wegorc"

# keep homedir tidy (unless this is the only config file)
if [ -f "$WEGORC" ] && [ -f ~/.wegorc ]; then
  rm -fv ~/.wegorc
fi
