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

if (( ${BASH_VERSINFO[0]}${BASH_VERSINFO[1]} >= 43 )); then
  HISTSIZE=-1                 # unlimited session history
  HISTFILESIZE=-1             # unlimited $HISTFILE size
else
  HISTSIZE=$((2 ** 10))       # remember 2^10 commands per session
  HISTFILESIZE=$((2 ** 15))   # store 2^15 lines in $HISTFILE
fi

HISTDIR="$HOME/.local/history"
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
HISTIGNORE+=':-?(-):.+(.):cd:dirs:dirs *'

# job control
HISTIGNORE+=':bg:fg:jobs'

# misc. commands
HISTIGNORE+=':clear:history*'

# directory listings
HISTIGNORE+=':ls*([1dflt]):ll'

# quittin'
HISTIGNORE+=':exit:bye'

# my own shortcuts
HISTIGNORE+=':d *:ef *:manpdf *:etest:f:i:mmin:rl:tt:vnc:vsmm'
HISTIGNORE+=':b@(a|rc|path|ps1)'

# my help commands
HISTIGNORE+=':@(h|wtf) *'

# -----------------------------------------------------------------------------

tophist()
{ # history sorted by frequency of use
  history \
  | awk "{print \$4}" \
  | awk "BEGIN{FS=\"|\"}{print \$1}" \
  | sort \
  | uniq -c \
  | sort -nr \
  | head -n 20
}

incognito()
{
  if [[ :$SHELLOPTS: == *:history:* ]]; then
    set +o history
    echo 'incognito mode enabled'
    Z_INCOGNITO=true
  else
    set -o history
    echo 'incognito mode disabled'
    unset -v Z_INCOGNITO
  fi
  rl prompt
}
