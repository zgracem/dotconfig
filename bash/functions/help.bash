# ------------------------------------------------------------------------------
# ~zozo/.config/bash/functions/help.bash
# ------------------------------------------------------------------------------
# h(): context-sensitive help
# -----------------------------------------------------------------------------

h()
{
    declare thing="$1"

    if quiet help "$thing"; then
        help -m "$thing" | less -F
        return 0
    elif quiet command man -w "$thing"; then
        man "$thing"
        return 0
    fi

    scold "${thing}: help not found"
    return 1
}

# -----------------------------------------------------------------------------
# other "helpful" functions
# -----------------------------------------------------------------------------

vimhelp()
{   # load vim's inline help for topic $1
    command vim -c "help $1" -c only
}
