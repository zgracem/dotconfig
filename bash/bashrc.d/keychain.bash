_inPath keychain || return

export GPG_TTY="$(tty)"

if [[ -z $SSH_AGENT_PID ]]; then
    eval $(keychain --dir "${HOME}/.keychain" \
           --eval --ignore-missing --inherit any --quick --quiet \
           id_rsa)
fi
