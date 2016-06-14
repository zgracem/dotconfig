rebash()
{ # start a fresh environment

  # clear_scrollback

  exec -c env - \
    HOME="$HOME" TERM="$TERM" \
    ${TERM_PROGRAM:+TERM_PROGRAM="$TERM_PROGRAM"} \
    ${SSH_CLIENT:+SSH_CLIENT="$SSH_CLIENT"} \
    ${SSH_CONNECTION:+SSH_CONNECTION="$SSH_CONNECTION"} \
    ${SSH_TTY:+SSH_TTY="$SSH_TTY"} \
    ${USERPROFILE:+USERPROFILE="$USERPROFILE"} \
    ${Z_SOLARIZED:+Z_SOLARIZED="$Z_SOLARIZED"} \
    "$SHELL" -l "$@"
}
