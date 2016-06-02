# -----------------------------------------------------------------------------
# ~/.config/bash/logout
# executed on logout
# -----------------------------------------------------------------------------

# set -o xtrace

# -----------------------------------------------------------------------------
# archive ~/.bash_history if it's larger than 128 KB
# -----------------------------------------------------------------------------

hfmax=$(( 128 * 1024 ))

if hfsize=$(wc -c "$HISTFILE" | cut -d" " -f1 2>/dev/null) && (( hfsize >= hfmax )); then
  if (( ${BASH_VERSINFO[0]}${BASH_VERSINFO[1]} >= 42 )); then
    printf -v HISTFILE_OLD "$HISTDIR/${HISTFILE##*/}_%(%F)T" -1
  else
    HISTFILE_OLD="$HISTDIR/${HISTFILE##*/}_$(date +%F)"
  fi
  
  /bin/mv "$HISTFILE" "$HISTFILE_OLD" \
  && touch "$HISTFILE"
fi

# -----------------------------------------------------------------------------
# machine-specific logout file
# -----------------------------------------------------------------------------

if [[ -f $dir_local/config/logout.bash ]]; then
  . "$dir_local/config/logout.bash"
fi

# printf "Be seeing you.\n"
