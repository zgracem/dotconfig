vars()
{   # display all variable values and attributes

    declare -p \
    | colourstrip \
    | sed -nE 's/^declare (.*)$/\1/p' \
    | sort -k2
}

allvars()
{
    vars \
    | command less
}

vgrep()
{
    vars \
    | grep -i "$@"
}
