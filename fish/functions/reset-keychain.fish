function reset-keychain
    set -q SSH_AGENT_PID; and kill $SSH_AGENT_PID
    set -Ug --erase SSH_AGENT_PID
    set -Ug --erase SSH_AUTH_SOCK
    killall ssh-agent 2>/dev/null # redundant if ssh-agent was $SSH_AGENT_PID
    return 0
end
