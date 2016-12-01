[[ $TERM_PROGRAM == Apple_Terminal ]] || return

# Setting `shopt -s histappend` and `HISTTIMEFORMAT` in bashrc.d/history.bash
# implicitly disables Apple Terminal's session-saving in El Capitan or later,
# and setting `SHELL_SESSION_HISTORY` to `0` in environment.d/apple_terminal.sh 
# makes it explicit.
if [[ -n $TERM_SESSION_ID ]]; then
  # Unset all functions set in /etc/bashrc_Apple_Terminal. (Requires GNU sed.)
  for func in $(sed -nE 's/.*\<(\w+)\(.*/\1/p' /etc/bashrc_Apple_Terminal); do
    unset -f "$func"
    unset -v func
  done

  # The presence of this file will also inhibit session-saving.
  [[ -f ~/.bash_sessions_disable ]] || touch ~/.bash_sessions_disable
else
  return 0
fi
