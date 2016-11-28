command -v screen >/dev/null || return

export SCREENDIR="$XDG_RUNTIME_DIR"
export SCREENRC="$XDG_CONFIG_HOME/screen/screenrc"

# Solarized Light colour scheme
if [ $Z_SOLARIZED == light ]; then
  SCREENRC="$dir_config/screen/screenrc.light"
fi

# fix screen's stupid broken $TERMCAP
# >> http://robmeerman.co.uk/unix/256colours
if [ $TERM == screen-256color -a -n $TERMCAP ]; then
  TERMCAP=${TERMCAP/Co#8/Co#256}
fi
