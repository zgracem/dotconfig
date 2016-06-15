# wego
# https://github.com/schachmat/wego

_inPath wego || return

export WEGORC="$dir_config/wegorc"

if [[ -f $WEGORC && -f ~/.wegorc ]]; then
  rm -fv ~/.wegorc
fi
