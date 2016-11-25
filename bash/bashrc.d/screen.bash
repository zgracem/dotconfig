_inPath screen || return

# Solarized Light colour scheme
if [[ $Z_SOLARIZED == light ]]; then
  SCREENRC="$dir_config/screen/screenrc.light"
fi

# fix screen's stupid broken $TERMCAP -- http://robmeerman.co.uk/unix/256colours
if [[ $TERM =~ screen-256color && -n $TERMCAP ]]; then
  TERMCAP=${TERMCAP/Co#8/Co#256}
fi

# -----------------------------------------------------------------------------

ss()
{ # reattach a session; detach/create it first if necessary
  if [[ -n $SCREENDIR && ! -d $SCREENDIR ]]; then
    command mkdir -pv -m 700 "$SCREENDIR"
  else
    chmod 700 "$SCREENDIR"
  fi

  command screen -d -R "$@"
  #               │  └─ reattach a session if one exists, otherwise create it
  #               └──── detach existing session if necessary
}
