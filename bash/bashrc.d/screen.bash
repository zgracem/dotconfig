if _inPath screen && [[ -n $SCREENDIR ]]; then
  mkdir -pv "$SCREENDIR"
  chmod 700 "$SCREENDIR"
fi
