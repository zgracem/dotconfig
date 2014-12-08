_zfind()
{   # general finding function
    # Usage: _zfind TYPE SCOPE STRING

    local usage="${FUNCNAME[0]} TYPE SCOPE STRING"

    local find_type="$1"; shift
    local scope="$1"; shift
    local term="$@"

    case $find_type in
        f|d)
            continue
            ;;
        file|dir)
            find_type="${find_type:0:1}"
            ;;
        *)
            scold "Usage: ${usage}"
            return 1
            ;;
    esac

    find -H "$scope" -type $find_type -iname '*'"${term}"'*' 2>&- \
    | sed "s|^${HOME}|~|g" \
    | grep -i --colour=auto "$term"

}

ff()
{   # find a file whose name contains a given string
    _zfind file "$PWD" "$@"
}

fd()
{   # find a directory whose name contains a given string
    _zfind dir "$PWD" "$@"
}

_zfind_daysold()
{   # list all files under $PWD changed in the last $1 days

    declare days="$1" find_bin

    if ! _isNumber "$days"; then
        scold "Error: $days: not a number"
        return 64
    elif ! find_bin=$(getGNU find); then
        scold "Error: GNU find(1) required"
        return 69
    fi

    if [[ $days -gt 0 ]]; then
        days="-${days}"
    fi

    "$find_bin" "$PWD" \
        -maxdepth 1 \
        -type f \
        -daystart \
        -mtime "$days" \
        -print
}

# list all files under $PWD changed today
today() { _zfind_daysold 0; }

# list all files under $PWD changed this week
thisweek() { _zfind_daysold -7; }
