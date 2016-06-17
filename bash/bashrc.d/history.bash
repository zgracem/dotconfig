# -----------------------------------------------------------------------------
# history
# -----------------------------------------------------------------------------

### ZGM added 2016-04-28 -- abort if history isn't enabled
[[ :$SHELLOPTS: =~ :history: ]] || return

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
  HISTFILESIZE=$((2 ** 16))   # store 2^16 lines in $HISTFILE
fi

HISTDIR="$HOME/.local/history"
mkdir -p "$HISTDIR" 1>/dev/null

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
HISTIGNORE+=':-?(-):.+(.):?(c)cd:dirs:dirs *'

# job control
HISTIGNORE+=':bg:fg:jobs'

# misc. commands
HISTIGNORE+=':clear:history*:pwd:mc'

# directory listings
HISTIGNORE+=':ls*([1dflt]):ll'

# quittin'
HISTIGNORE+=':exit:bye'

# my own shortcuts
HISTIGNORE+=':d *:e *:fe *:manpdf *:c:c[sl]:etest:f:rl:ss:tt:vnc:vsmm'
HISTIGNORE+=':b@(a|rc|col|f|loc|path|dirs|pri|pro|ps1)'

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
  if _optSet history; then
    set +o history
    echo 'incognito mode enabled'
    Z_INCOGNITO=true
  else
    set -o history
    echo 'incognito mode disabled'
    unset -v Z_INCOGNITO
  fi
}
