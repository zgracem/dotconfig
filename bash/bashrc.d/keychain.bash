_inPath keychain || return

export GPG_TTY="$(tty)"

if [[ -z $SSH_AGENT_PID ]]; then
  if [[ ! -d ~/var/run ]]; then
    mkdir -p ~/var/run 1>/dev/null || return
  fi

  printf "\r\e[K"

  if keychain_env=$(keychain --eval --dir ~/var/run --quick --quiet \
                    --ignore-missing --inherit any id_rsa); then
    eval "$keychain_env"
    printf "\eM\e[K"
  fi
fi

unset -v keychain_env

# TODO: remove later
[[ -d ~/var/run/.keychain ]] && rm -rfv ~/.keychain
