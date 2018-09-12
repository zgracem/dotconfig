# -----------------------------------------------------------------------------
# ~/.bash_logout
# Executed by bash(1) on logout
# -----------------------------------------------------------------------------

# archive bash history if it's larger than 128 KB
if [[ -f $HISTFILE ]]; then
  history_max_bytes=$(( 128 * 1024 ))
  history_size_bytes=$(wc -c "$HISTFILE" | cut -d" " -f1)

  if (( history_size_bytes >= history_max_bytes )); then
    if (( ${BASH_VERSINFO[0]}${BASH_VERSINFO[1]} >= 42 )); then
      printf -v HISTFILE_OLD "$HISTDIR/${HISTFILE##*/}_%(%F)T" -1
    else
      HISTFILE_OLD="$HISTDIR/${HISTFILE##*/}_$(date +%F)"
    fi
    
    /bin/mv "$HISTFILE" "$HISTFILE_OLD" && touch "$HISTFILE"
  fi
fi

# run machine-specific logout file
if [[ -f ~/.local/config/logout.bash ]]; then
  # shellcheck disable=SC1090
  . ~/.local/config/logout.bash
fi

return 0
