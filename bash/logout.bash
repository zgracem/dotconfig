# -----------------------------------------------------------------------------
# ~zozo/.config/bash/logout                                  executed on logout
# say hello: printf "zozo\x40inescapable\x2eorg"
# -----------------------------------------------------------------------------

# revoke sudo privileges
if [[ $(who | grep -ch "^$USER\>") -le 2 ]]; then
    _inPath sudo && sudo -k
fi

# archive ~/.bash_history if it's larger than 256 KB
if _isGNU stat; then
    flags='-c %s'
else
    flags='-f %z'
fi

if [[ $(command stat ${flags} "$HISTFILE" 2>/dev/null) -ge 262144 ]]; then
    mv "$HISTFILE" "${HISTFILE}_$(date +%y%m%d)"
    touch "$HISTFILE"
fi

unset flags
