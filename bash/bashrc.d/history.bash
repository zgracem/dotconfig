# -----------------------------------------------------------------------------
# history
# -----------------------------------------------------------------------------

# Abort if history isn't enabled
[[ :$SHELLOPTS: == *:history:* ]] || return

shopt -s cmdhist        # combine multiline commands into one in history
shopt -s histappend     # append to the history file, don't overwrite it
shopt -s histreedit     # re-edit failed history substitutions
shopt -u histverify     # [don't] review/change history substitutions before executing

HISTTIMEFORMAT='%F %T '

# history file

if [[ ${BASH_VERSINFO[0]}${BASH_VERSINFO[1]} -ge 43 ]]; then
  HISTSIZE=-1                 # unlimited session history
  HISTFILESIZE=-1             # unlimited $HISTFILE size
else
  HISTSIZE=$((2 ** 10))       # remember 2^10 commands per session
  HISTFILESIZE=$((2 ** 15))   # store 2^15 lines in $HISTFILE
fi

HISTDIR="${XDG_STATE_HOME:-$HOME/.local/state}/bash"
mkdir -pv "$HISTDIR"
HISTFILE="$HISTDIR/bash_history"

# -----------------------------------------------------------------------------
# commands to ignore
# -----------------------------------------------------------------------------

unset -v HISTCONTROL HISTIGNORE

HISTCONTROL='ignoredups'    # ignore duplicate commands
HISTCONTROL+=':ignorespace' # ignore commands that start w/ ' '
# HISTCONTROL+=':erasedups' # erase previous identical lines from history

# no-ops
HISTIGNORE='true:false'

# navigation
HISTIGNORE+=':-:--:.:..:cd:dirs:dirs *'

# job control
HISTIGNORE+=':bg:fg:jobs'

# misc. commands
HISTIGNORE+=':clear:help *:history:history *'

# directory listings
HISTIGNORE+=':ls*([1dflt]):ll'

# quittin'
HISTIGNORE+=':exit:bye'

# my own shortcuts
HISTIGNORE+=':d *:ef *:manpdf *:etest:f:h *:i:mmin:rl:tt:vnc:vsmm'
HISTIGNORE+=':ba:brc:bpath:bps1'
