console()
{ #: - scan system messages from Terminal (in a new window, if applicable)
  #: $ console [-w] [<log_file>]
  #: | -w = wide view: split window horizontally instead
  #: > http://brettterpstra.com/a-simple-but-handy-bash-function-console/

  local -a locations=("$1" /var/log/system.log /var/log/messages)
  local log_file

  for log_file in "${locations[@]}"; do
    if [[ -r $log_file ]]; then
      break
    else
      unset -v log_file
    fi
  done

  if [[ -z $log_file ]]; then
    scold "${FUNCNAME[0]}: no log file found"
    return 72
  fi

  if [[ $1 == -w ]] && _inTmux; then
    command tmux split-window "tail -n $(( LINES * 2 )) -f '${log_file}'"
  else
    newwin -t console tail -n $(( LINES * 2 )) -f "${log_file}"
  fi
}
