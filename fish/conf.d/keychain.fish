if status is-interactive; and in-path keychain; and not set -gq SSH_AGENT_PID
  set -l keys id_{ed25519,rsa_2020}

  set -Ue SSH_AUTH_SOCK
  set -Ue SSH_AGENT_PID

  set -l keychain_dir "$XDG_RUNTIME_DIR/keychain"
  set -l ssh_env $keychain_dir/.env

  set -l params      --eval --quick --quiet
  set params $params --absolute --dir "$keychain_dir"
  set params $params --inherit any --ignore-missing

  if test -d "$keychain_dir"
    set -lx SHELL (status fish-path 2>/dev/null; or command -s fish)
    if keychain $params $keys > $ssh_env
      command chmod 600 $ssh_env
      source $ssh_env
    end
  end
end
