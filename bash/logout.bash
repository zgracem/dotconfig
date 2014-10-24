# -----------------------------------------------------------------------------
# ~zozo/.config/bash/logout                                  executed on logout
# say hello: printf "zozo\x40inescapable\x2eorg"
# -----------------------------------------------------------------------------

# revoke sudo privileges
if _inPath sudo && [[ $(who | grep -ch "^$USER\>") -le 2 ]]; then
    sudo -k
fi

# archive ~/.bash_history if it's larger than 128 KB
if _isGNU stat; then
    flags='-c %s'
else
    flags='-f %z'
fi

if [[ $(command stat ${flags} "$HISTFILE" 2>/dev/null) -ge 131072 ]]; then
	mkdir -p "${HOME}/Archive" \
	&& {
	    mv "$HISTFILE" "${HOME}/Archive/${HISTFILE}_$(date +%y%m%d)"
	    touch "$HISTFILE"
	}
fi

unset flags
