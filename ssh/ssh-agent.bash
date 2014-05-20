# -----------------------------------------------------------------------------
# start SSH agent
# -----------------------------------------------------------------------------

# stop sourcing if ssh-agent isn't in $PATH
if ! _inPath ssh-agent; then
    return
fi

# don't use ~/.ssh/environment; it already has a different purpose in SSH
ssh_env="$HOME/.ssh/ssh-agent.environment"

# check status of ssh-agent
ssh-add -l &>/dev/null

case $? in
    0)  # agent running w/ keys -- do nothing
        return 0
        ;;

    1)  # agent running w/out keys -- add them
        ssh-add
        ;;

    2)  # agent not running
        ssh-agent >| "$ssh_env"     # start the agent
        . "$ssh_env" &>/dev/null    # set $SSH_AUTH_SOCK and $SSH_AGENT_PID
        export SSH_AGENT_PPID=$$    # set parent process (i.e. bash) ID
        ssh-add                     # add keys
        ;;
esac

