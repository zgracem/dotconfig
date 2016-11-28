export MAIL="/var/mail/$USER"
export MBOX=~/.mail/mbox
export DEAD=~/.mail/dead.letter

MAILCAPS="$XDG_DATA_HOME/mailcap"

if [[ -d $MAILCAPS ]]; then
  export MAILCAPS
else
  unset -v MAILCAPS
fi
