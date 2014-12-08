# -----------------------------------------------------------------------------
# history
# -----------------------------------------------------------------------------

shopt -s cmdhist        # combine multiline commands into one in history
shopt -s histappend     # append to the history file, don't overwrite it
shopt -s histreedit     # re-edit failed history substitutions
shopt -s histverify     # review/change history substitutions before executing

HISTCONTROL=ignoredups:ignorespace:erasedups
HISTTIMEFORMAT='%F %T '

HISTIGNORE='-:--:..*:cd'
HISTIGNORE+=':bg:fg'
HISTIGNORE+=':clear:history:pwd'
HISTIGNORE+=':bye:exit:\:wq'
HISTIGNORE+=':c:c[sl]'
HISTIGNORE+=':f:ss:tt'

HISTFILE="$HOME/.bash_history"

if (( BASH_VERSINFO[0] >= 4 )) && (( BASH_VERSINFO[1] >= 3 )); then
    HISTSIZE=-1                 # unlimited session history
    HISTFILESIZE=-1             # unlimited $HISTFILE size
else
    HISTSIZE=$((2 ** 8))        # remember 2^8 commands per session
    HISTFILESIZE=$((2 ** 16))   # store 2^16 lines in $HISTFILE
fi

# append to HISTFILE, then read from HISTFILE
PROMPT_COMMAND='history -a; history -n'

# colourize shell history
HISTTIMEFORMAT="${esc_2d}${HISTTIMEFORMAT}${esc_null}"
