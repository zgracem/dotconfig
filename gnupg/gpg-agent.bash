# -----------------------------------------------------------------------------
# start GPG agent
# -----------------------------------------------------------------------------

# stop sourcing if gpg-agent isn't in $PATH
if ! _inPath gpg-agent; then
    return
fi

# to set $GPG_AGENT_INFO with socket and PID
gpg_env=$HOME/.gnupg/gpg-agent.environment

_gpg_agent_is_running()
{   # return 0 if the agent is already running

    declare pid=$(echo $GPG_AGENT_INFO | cut -d: -f2)

    if [[ -n $pid ]]; then
        command ps -p "$pid" &>/dev/null
        return $?
    else
        return 1
    fi
}

# -----------------------------------------------------------------------------

# check status of gpg-agent
if ! _gpg_agent_is_running; then
    gpg-agent --daemon >| "$gpg_env"    # start the agent

    . "$gpg_env" &>/dev/null            # set & export $GPG_AGENT_INFO
    GPG_AUTH_SOCK=$(echo $GPG_AGENT_INFO | cut -d: -f1)
    GPG_AGENT_PID=$(echo $GPG_AGENT_INFO | cut -d: -f2)
    GPG_AGENT_PPID=$$                   # set parent process (i.e. bash) ID
    GPG_TTY=$(tty)                      # for PIN entry program, if any

    export GPG_AUTH_SOCK GPG_AGENT_PID GPG_AGENT_PPID GPG_TTY
fi
