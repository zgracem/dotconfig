_inPath keychain || return

export GPG_TTY="$(tty)"

if [[ -z $SSH_AGENT_PID ]]; then
  printf "\r\e[K"
  eval $(keychain --dir "${HOME}/.keychain" \
       --eval --ignore-missing --inherit any --quick --quiet \
       id_rsa) \
  && printf "\eM\e[K"
fi
