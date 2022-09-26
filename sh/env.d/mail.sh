export MBOX=~/.mail/mbox
export DEAD=~/.mail/dead.letter

[ -z "$MAIL" ] && MAIL="/var/mail/$USER"
if [ -r "$MAIL" ]; then
  export MAIL
else
  unset -v MAIL
fi

MAILCAPS="$XDG_DATA_HOME/mailcap"
if [ -r "$MAILCAPS" ]; then
  export MAILCAPS
else
  unset -v MAILCAPS
fi
