# -----------------------------------------------------------------------------
# ~zozo/.config/bash/logout                                  executed on logout
# say hello: printf "zozo\x40inescapable\x2eorg"
# -----------------------------------------------------------------------------

# revoke sudo privileges
if [[ $(who | grep -ch "^$USER\>") -le 2 ]]; then
    _inPath sudo && sudo -k
fi

# stop ssh-agent if it was started by this shell
if [[ -n $SSH_AGENT_PID && $$ -eq $SSH_AGENT_PPID ]]; then
    # delete all identities from the agent
    ssh-add -D &>/dev/null

    # terminate the agent process
    builtin kill $SSH_AGENT_PID &>/dev/null && {
        # clean up
        if [[ -d ${SSH_AUTH_SOCK%/*} ]]; then
            command rm -rf "${SSH_AUTH_SOCK%/*}" &>/dev/null
        fi

        unset SSH_AUTH_SOCK SSH_AGENT_PID SSH_AGENT_PPID
    }
fi

# ditto for gpg-agent
if [[ -n $GPG_AGENT_PID && [[ $$ -eq $GPG_AGENT_PPID ]]; then
    # terminate the agent process
    builtin kill $GPG_AGENT_PID &>/dev/null && {
        # clean up
        if [[ -d ${GPG_AUTH_SOCK%/*} ]]; then
            command rm -rf "${GPG_AUTH_SOCK%/*}" &>/dev/null
        fi

        unset GPG_AUTH_SOCK GPG_AGENT_PID GPG_AGENT_PPID GPG_TTY
    }
fi

# archive ~/.bash_history if it's larger than 256 KB
if _isGNU stat; then
    flags='-c %s'
else
    flags='-f %z'
fi

history_size=$(command stat ${flags} "$HISTFILE" 2>/dev/null)

if [[ $history_size -ge 262144 ]]; then
    mv "$HISTFILE" "${HISTFILE}_$(date +%y%m%d)"
fi

unset flags history_size

# # clear screen
# if [[ $SHLVL -eq 1 ]]; then
#     _inPath clear && clear
# fi
