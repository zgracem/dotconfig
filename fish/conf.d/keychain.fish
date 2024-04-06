# On Windows 10 v.1803 >= Build 17134.48 (Update KB4103721, 2018-05-08), you
# must also execute the following in a PowerShell session w/ admin privileges:
#
#     Set-Service ssh-agent -StartupType Manual
#
status is-interactive; and command -q keychain; and not set -gq SSH_AGENT_PID
or return

set -l keys id_ed25519

set -Ue SSH_AUTH_SOCK
set -Ue SSH_AGENT_PID

set -l keychain_dir "$XDG_RUNTIME_DIR/keychain"
mkdir -p $keychain_dir; or return
set -l ssh_env $keychain_dir/.env

set -l params --eval --quick --inherit any
set -a params --dir "$keychain_dir" --absolute
set -a params --quiet --ignore-missing

set -lx SHELL (status fish-path 2>/dev/null; or command -s fish)
set -p PATH ~/opt/bin /usr/local/bin
keychain $params $keys >$ssh_env

if test -s $ssh_env # ssh-agent loaded, or existing agent found
    command chmod 600 $ssh_env
    source $ssh_env
    return 0
else # `keychain` command failed and (hopefully) printed to stderr
    command rm $ssh_env
    return 1
end
