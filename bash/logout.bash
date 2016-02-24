# -----------------------------------------------------------------------------
# ~/.config/bash/logout
# executed on logout
# -----------------------------------------------------------------------------

# set -o xtrace

# -----------------------------------------------------------------------------
# archive ~/.bash_history if it's larger than 128 KB
# -----------------------------------------------------------------------------

hfmax=$(( 128 * 1024 ))
HISTDIR="$HOME/Archive/history"

if _isGNU stat; then
    flags='-c %s'
else
    flags='-f %z'
fi

if hfsize=$(command stat $flags "$HISTFILE" 2>/dev/null) && (( hfsize >= hfmax )); then
    HISTFILE_OLD="$HISTDIR/${HISTFILE##*/.}_$(date +%y%m%d)"
    
    mkdir -p "$HISTDIR" \
    && /bin/mv "$HISTFILE" "$HISTFILE_OLD" \
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
