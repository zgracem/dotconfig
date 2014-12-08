# -----------------------------------------------------------------------------
# ~zozo/.config/bash/logout
# executed on logout
# -----------------------------------------------------------------------------

# revoke sudo privileges
if _inPath sudo && (( $(who | command grep -chw "^$USER") < 2 )); then
    sudo -k
fi

# archive ~/.bash_history if it's larger than 128 KB
if _isGNU stat; then
    flags='-c %s'
else
    flags='-f %z'
fi

if (( $(command stat ${flags} "$HISTFILE" 2>/dev/null) >= (128 * 1024) )); then
    command mkdir -p "${HOME}/Archive" \
        && {
            command mv "$HISTFILE" "${HOME}/Archive/${HISTFILE}_$(date +%y%m%d)"
            command touch "$HISTFILE"
        }
fi

unset -v flags
