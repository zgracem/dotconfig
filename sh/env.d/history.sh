# -----------------------------------------------------------------------------
# default settings -- can be overridden by shell-specific runcoms
# -----------------------------------------------------------------------------

HISTSIZE=1024       # keep __ commands per session
HISTFILESIZE=32768  # keep __ lines in $HISTFILE

test -z "$XDG_STATE_HOME" && export XDG_STATE_HOME="$HOME/.local/state"
HISTDIR="$XDG_STATE_HOME/sh"
mkdir -pv "$HISTDIR"
HISTFILE="$HISTDIR/sh_history"
