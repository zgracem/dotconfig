# -----------------------------------------------------------------------------
# mail
# -----------------------------------------------------------------------------

MAIL="/var/mail/$USER"

if [[ -r $MAIL ]]; then
    MBOX="$HOME/.mail/mbox"

    # Create personal mail directory if it doesn't exist.
    if [[ ! -d ${MBOX%/*} ]]; then
      mkdir -vp "${MBOX%/*}"
    fi

    shopt -s mailwarn       # alert on new mail
    MAILCHECK=300           # check mail every 5 minutes
    MAILPATH="$MAIL"'?New mail in $_':"$MBOX"'?New mail in $_'
else
    unset -v MAIL MAILCHECK MAILPATH
fi

# mailcaps
export MAILCAPS="${HOME}/share/mailcap"
