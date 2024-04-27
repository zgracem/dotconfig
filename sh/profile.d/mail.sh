export MBOX=~/.mail/mbox
export DEAD=~/.mail/dead.letter

[ -z "$MAIL" ] && MAIL="/var/mail/$USER"
if [ -r "$MAIL" ]; then
  export MAIL
else
  unset -v MAIL
fi

MAILCAPS="$XDG_CONFIG_HOME/mailcap/mailcap"
if [ -d "$MAILCAPS" ]; then
  export MAILCAPS
else
  unset -v MAILCAPS
fi
