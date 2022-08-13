if [[ $TERM_PROGRAM == Apple_Terminal && -n $TERM_SESSION_ID ]]; then
  # Unset all functions set in /etc/bashrc_Apple_Terminal. (Requires GNU sed.)
  sed -nE 's/.*\<(\w+)\(.*/\1/p' < /etc/bashrc_Apple_Terminal \
  | while IFS= read -r func; do
    unset -f "$func"
    unset -v func
  done
else
  return 0
fi
