h()
{   # context-sensitive help

    local thing="$1"

    if quietly help "$thing"; then
        help -m "$thing" \
        | less -F
    elif quietly command man -w "$thing"; then
        man "$thing"
    elif _inPath "$thing" && "$thing" --help 2>/dev/null; then
        return 0
    else
        scold "${thing}: help not found"
        return 1
    fi
}

