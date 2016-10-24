[[ $TERM_PROGRAM == Apple_Terminal ]] || return

# Setting `shopt -s histappend` and `HISTTIMEFORMAT` in bashrc.d/history.bash
# implicitly disables Apple Terminal's session-saving in El Capitan or later,
# but let's make it explicit for good measure.
if [[ -n $TERM_SESSION_ID ]]; then
  export SHELL_SESSION_HISTORY=0

  # Unset all functions set in /etc/bashrc_Apple_Terminal. (Requires GNU sed.)
  for func in $(sed -nE 's/.*\<(\w+)\(.*/\1/p' /etc/bashrc_Apple_Terminal); do
    unset -f "$func"
    unset -v func
  done

  # The presence of this file will also inhibit session-saving.
  [[ -f ~/.bash_sessions_disable ]] || touch ~/.bash_sessions_disable

  # Keep homedir tidy.
  z_tidy ~/.bash_sessions
else
  return 0
fi
