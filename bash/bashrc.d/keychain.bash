_inPath keychain || return

if [[ -z $SSH_AGENT_PID ]]; then
  keychain_dir="$XDG_RUNTIME_DIR/keychain"
  [[ -d $keychain_dir ]] || mkdir -pv "$keychain_dir"

  [[ :$SHELLOPTS: == *:noclobber:* ]] || trap 'set -o noclobber; trap - RETURN;' RETURN
  set +o noclobber

  verbose "> ${Z_RELOADING+re-}initializing ssh-agent..."
  if keychain_env=$(keychain --agents ssh \
                             --absolute --dir "$keychain_dir" \
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
  
  unset -v keychain_dir keychain_env
fi
