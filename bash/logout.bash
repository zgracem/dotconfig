# -----------------------------------------------------------------------------
# ~/.config/bash/logout
# executed on logout
# -----------------------------------------------------------------------------

# archive ~/.bash_history if it's larger than 256 KB
history_max_bytes=$(( 256 * 1024 ))
history_size_bytes=$(wc -c "$HISTFILE" | cut -d" " -f1 2>/dev/null)

if (( history_size_bytes >= history_max_bytes )); then
  if (( ${BASH_VERSINFO[0]}${BASH_VERSINFO[1]} >= 42 )); then
    printf -v HISTFILE_OLD "$HISTDIR/${HISTFILE##*/}_%(%F)T" -1
  else
    HISTFILE_OLD="$HISTDIR/${HISTFILE##*/}_$(date +%F)"
  fi
  
  /bin/mv "$HISTFILE" "$HISTFILE_OLD" && touch "$HISTFILE"
fi

# run machine-specific logout file
if [[ -f ~/.local/config/logout.bash ]]; then
  . ~/.local/config/logout.bash
fi

return 0
