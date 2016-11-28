_inPath screen || return

if [[ -n $SCREENDIR && ! -d $SCREENDIR ]]; then
  mkdir -pv -m 700 "$SCREENDIR"
else
  chmod 700 "$SCREENDIR"
fi

ss()
{ # reattach a session; detach/create it first if necessary
  command screen -d -R "$@"
  #               │  └─ reattach a session if one exists, otherwise create it
  #               └──── detach existing session if necessary
}
