# -----------------------------------------------------------------------------
# mail
# -----------------------------------------------------------------------------

MAIL="/var/mail/$USER"

if [[ -r $MAIL ]]; then
  export MBOX=~/.mail/mbox
  export DEAD=~/.mail/dead.letter

  # Create personal mail directory if it doesn't exist.
  [[ -d ${MBOX%/*} ]] || mkdir -pv "${MBOX%/*}"

  shopt -s mailwarn       # alert on new mail
  MAILCHECK=300           # check mail every 5 minutes
  MAILPATH="$MAIL"'?New mail in $_':"$MBOX"'?New mail in $_'
else
  unset -v MAIL MAILCHECK MAILPATH MBOX
fi

# mailcaps
export MAILCAPS="$XDG_DATA_HOME/mailcap"

if [[ ! -d $MAILCAPS ]]; then
  unset -v MAILCAPS
fi
