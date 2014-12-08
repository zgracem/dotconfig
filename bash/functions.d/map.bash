map()
{   # applies a function to each item in a list
    # Usage: map COMMAND: ITEM [ITEM ...]
    # Based on: http://redd.it/aks3u

    declare usage="$FUNCNAME COMMAND: ITEM [ITEM ...]"
    declare i cmd

    if [[ $# -lt 2 ]] || [[ ! $@ =~ :[[:space:]] ]]; then
        scold $FUNCNAME "invalid syntax"
        scold "Usage: $usage"
        return 1
    fi

    until [[ $1 =~ :$ ]]; do
        cmd+="$1 "
        shift
    done

    cmd+="${1%:} "
    shift

    for i in "$@"; do
        eval "${cmd//\\/\\\\} \"${i//\\/\\\\}\""
    done
}
