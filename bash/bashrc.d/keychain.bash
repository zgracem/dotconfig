_inPath keychain || return

if [[ -z $SSH_AGENT_PID ]]; then
  # We need to ensure noclobber is off so keychain can overwrite the files
  # holding its environment info. If it was enabled, set a self-clearing trap
  # to turn it back on when this file RETURNs from being sourced.
  [[ :$SHELLOPTS: == *:noclobber:* ]] || trap 'set -o noclobber; trap - RETURN;' RETURN
  set +o noclobber

  verbose "> ${Z_RELOADING+re-}initializing ssh-agent..."

  if keychain_env=$(keychain --agents ssh \
                             --absolute --dir "$XDG_RUNTIME_DIR/keychain" \
                             --ignore-missing \
                             --inherit any \
                             --quick --quiet \
                             --eval \
                             id_ed25519 id_rsa)
  then
    eval "$keychain_env"
    verbose 2 ">> export SSH_AUTH_SOCK=$SSH_AUTH_SOCK"
    verbose 2 ">> export SSH_AGENT_PID=$SSH_AGENT_PID"
  fi
  
  unset -v keychain_env
fi
