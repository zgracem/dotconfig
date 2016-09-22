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

  if [[ ! -f ~/.bash_sessions_disable ]]; then
    command touch ~/.bash_sessions_disable &>/dev/null
  fi
else
  return 0
fi

unset -f terminal_app_functions
