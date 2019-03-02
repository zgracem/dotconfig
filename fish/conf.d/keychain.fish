if status is-interactive; and in-path keychain; and not set -q SSH_AGENT_PID
  set -lx SHELL (status fish-path)
  set -l keys id_ed25519 id_rsa
  set -l keychain_env (keychain --eval --quick --quiet \
              --absolute --dir "$XDG_RUNTIME_DIR/keychain" \
              --inherit any \
              --ignore-missing $keys)
  or exit

  eval $keychain_env
end
