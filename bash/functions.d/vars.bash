allvars()
{
    local LESS= # suppress preferences in environment

    declare -p \
    | less -FQX
}

vgrep()
{
    # vars \
    # | grep -i "$@"
    local LESS= # suppress preferences in environment

    declare -p \
    | grep -i "$@" \
    | less -EQX

    # TODO: use LESSOPEN?
}
