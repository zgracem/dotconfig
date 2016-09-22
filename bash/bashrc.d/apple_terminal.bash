[[ $TERM_PROGRAM == Apple_Terminal ]] || return

# Setting `shopt -s histappend` and `HISTTIMEFORMAT` in bashrc.d/history.bash
# implicitly disables Apple Terminal's session-saving in El Capitan or later,
# but let's make it explicit for good measure.
if [[ -n $TERM_SESSION_ID ]]; then
  export SHELL_SESSION_HISTORY=0

  # Unset all functions set in /etc/bashrc_Apple_Terminal. (Requires GNU sed.)
  for func in $(sed -nE 's/.*\<(\w+)\(.*/\1/p' /etc/bashrc_Apple_Terminal); do
    unset -f "$func"
  done

  ### ZGM disabled 2016-06-17 -- Possibly faster than the above, though.
  # unset -f update_terminal_cwd shell_session_{save_user_state,history_allowed,history_enable,history_check,save_history,save,delete_expired,update}
  
  while [[ ! -e ~/.bash_sessions_disable ]]
  do
    command cp ~/etc/skel/.bash_sessions_disable "$HOME"
    command touch ~/.bash_sessions_disable || break
  done &>/dev/null
else
  return 0
fi
