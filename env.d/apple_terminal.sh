# Setting `shopt -s histappend` and `HISTTIMEFORMAT` in bashrc.d/history.bash
# implicitly disables Apple Terminal's session-saving in El Capitan or later,
# but let's make it explicit for good measure.
if [ -n $TERM_SESSION_ID ]; then
  export SHELL_SESSION_HISTORY=0
fi
