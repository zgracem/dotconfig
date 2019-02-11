rebash()
{ # start a fresh environment

  exec -c env - \
    HOME="$HOME" TERM="$TERM" \
    ${TERM_PROGRAM:+TERM_PROGRAM="$TERM_PROGRAM"} \
    ${SSH_CLIENT:+SSH_CLIENT="$SSH_CLIENT"} \
    ${SSH_CONNECTION:+SSH_CONNECTION="$SSH_CONNECTION"} \
    ${SSH_TTY:+SSH_TTY="$SSH_TTY"} \
    ${USERPROFILE:+USERPROFILE="$USERPROFILE"} \
    "$SHELL" -l "$@"
}
