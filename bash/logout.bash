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
    builtin kill $SSH_AGENT_PID && {
        # clean up
        if [[ -d ${SSH_AUTH_SOCK%/*} ]]; then
            command rm -rf "${SSH_AUTH_SOCK%/*}" &>/dev/null
        fi

        unset SSH_AUTH_SOCK SSH_AGENT_PID SSH_AGENT_PPID
    }
fi

# ditto for gpg-agent
if _gpg_agent_is_running && [[ $$ -eq $GPG_AGENT_PPID ]]; then
    # terminate the agent process
    builtin kill $GPG_AGENT_PID && {
        # clean up
        if [[ -d ${GPG_AUTH_SOCK%/*} ]]; then
            command rm -rf "${GPG_AUTH_SOCK%/*}" &>/dev/null
        fi

        unset GPG_AUTH_SOCK GPG_AGENT_PID GPG_AGENT_PPID GPG_TTY
    }
fi

# # clear screen
# if [[ $SHLVL -eq 1 ]]; then
#     _inPath clear && clear
# fi
