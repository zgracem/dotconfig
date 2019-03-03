if status is-interactive; and in-path keychain; and not set -q SSH_AGENT_PID
  set -Ue SSH_AUTH_SOCK
  set -l keys id_{ed25519,rsa}

  set -l keychain_dir "$XDG_RUNTIME_DIR/keychain"
  set -l ssh_env $keychain_dir/.env

  set -l params --eval --quick --quiet
  set -a params --absolute --dir "$keychain_dir"
  set -a params --inherit any --ignore-missing

  set -lx SHELL (status fish-path)
  keychain $params $keys > $ssh_env
  command chmod 600 $ssh_env
  source $ssh_env
end
