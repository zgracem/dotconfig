# -----------------------------------------------------------------------------
# email
# -----------------------------------------------------------------------------

if [[ -r $MAIL ]]; then
  shopt -s mailwarn       # alert on new mail
  MAILCHECK=300           # check mail every 5 minutes
  MAILPATH="$MAIL"'?New mail in $_':"$MBOX"'?New mail in $_'
else
  unset -v MAIL MAILCHECK MAILPATH MBOX
fi
