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
    HISTFILE_OLD="$HISTDIR/${HISTFILE##*/}_$(date +%F)"
    
    /bin/mv "$HISTFILE" "$HISTFILE_OLD" \
    && touch "$HISTFILE"
fi

# -----------------------------------------------------------------------------
# machine-specific logout file
# -----------------------------------------------------------------------------

if [[ -f $dir_local/logout.bash ]]; then
    . "$dir_local/logout.bash"
else
    return 0
fi
