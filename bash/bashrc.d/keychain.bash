_inPath keychain || return

if [[ -z $SSH_AGENT_PID ]]; then
  # We need to ensure noclobber is off so keychain can overwrite the files
  # holding its environment info. If it was enabled, set a self-clearing trap
  # to turn it back on when this file RETURNs from being sourced.
  [[ :$SHELLOPTS: == *:noclobber:* ]] || trap 'set -o noclobber; trap - RETURN;' RETURN
  set +o noclobber

  if [[ -n $VERBOSITY ]]; then
    printf '%b\n' "> ${Z_RELOADING+re-}initializing ssh-agent..."
  fi

  if keychain_env=$(SHELL=$BASH keychain --agents ssh \
                             --absolute --dir "$XDG_RUNTIME_DIR/keychain" \
                             --ignore-missing \
                             --inherit any \
                             --quick --quiet \
                             --eval \
                             id_ed25519 id_rsa)
  then
    eval "$keychain_env"
  fi
  
  unset -v keychain_env
fi
