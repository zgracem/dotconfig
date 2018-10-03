# -----------------------------------------------------------------------------
# email
# -----------------------------------------------------------------------------

if [[ -r $MAIL ]]; then
  # alert on new mail
  shopt -s mailwarn
  # check mail every __ seconds
  MAILCHECK=60
  # custom notifications (`$_` will be expanded later)
  # shellcheck disable=SC2016
  MAILPATH="$MAIL"'?New mail in $_':"$MBOX"'?New mail in $_'
else
  unset -v MAIL MAILCHECK MAILPATH MBOX
fi
