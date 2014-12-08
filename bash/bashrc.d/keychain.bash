# start keychain
if _inPath keychain; then
    export GPG_TTY="$(tty)"

    eval $(keychain --dir "${HOME}/.local/keychain" --eval --inherit any --quick --quiet id_rsa)
fi
