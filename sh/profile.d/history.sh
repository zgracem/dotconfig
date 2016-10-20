# -----------------------------------------------------------------------------
# shell history
# -----------------------------------------------------------------------------

HISTSIZE=1024       # keep [x] commands per session
HISTFILESIZE=32768  # keep [x] lines in $HISTFILE

HISTDIR="$HOME/.local/history"
mkdir -pv "$HISTDIR"
HISTFILE="$HISTDIR/sh_history"
