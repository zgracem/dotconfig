# -----------------------------------------------------------------------------
# shell history
# -----------------------------------------------------------------------------

HISTSIZE=1024       # keep [x] commands per session
HISTFILESIZE=32768  # keep [x] lines in $HISTFILE

HISTDIR="$HOME/.local/history"
mkdir -p "$HISTDIR" >/dev/null
HISTFILE="$HISTDIR/sh_history"
