# -----------------------------------------------------------------------------
# mail
# -----------------------------------------------------------------------------

if [[ -r $MAIL ]]; then
    shopt -s mailwarn       # alert on new mail
    MAILCHECK=300           # check mail every 5 minutes
    MAILPATH=$MAIL?'New mail in $_'
else
    unset -v MAILCHECK
fi

# mailcaps
export MAILCAPS="${HOME}/share/mailcap:${HOME}/.mailcap:/etc/mailcap"
