# ------------------------------------------------------------------------------
# ~zozo/.config/bash/functions/help.bash
# ------------------------------------------------------------------------------
# h(): context-sensitive help
# -----------------------------------------------------------------------------

h()
{
    declare thing="$1"

    if quietly help "$thing"; then
        help -m "$thing" \
        | less -F
    elif quietly command man -w "$thing"; then
        man "$thing"
    else
        scold "${thing}: help not found"
        return 1
    fi
}

# -----------------------------------------------------------------------------
# other "helpful" functions
# -----------------------------------------------------------------------------

vimhelp()
{   # load vim's inline help for topic $1
    command vim -c "help $1" -c only
}
