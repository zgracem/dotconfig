_z_find()
{   # general finding function
    # Usage: _z_find f[ile]|d[ir] SCOPE TERM

    local find_type=$1 scope=$2; shift 2
    local term=$@

    case $find_type in
        f|d)
            continue
            ;;
        file|dir)
            find_type="${find_type:0:1}"
            ;;
        *)
            scold "Usage: ${FUNCNAME[0]} f[ile]|d[ir] SCOPE TERM"
            return 1
            ;;
    esac

    find -H "$scope" -xtype $find_type -iname '*'"$term"'*' -print 2>/dev/null \
    | sed "s|^$HOME|~|g" \
    | command grep -i --colour=auto "$term"

}

_z_find_daysold()
{   # list all files in $PWD changed in the last $1 days

    local days="$1" find_bin
    local number_re='^-?[[:digit:]]+$'

    if ! [[ $days =~ $number_re ]]; then
        scold "Error: $days: not a number"
        return 1
    elif ! _isGNU find; then
        scold "Error: GNU find(1) required"
        return 1
    fi

    if (( days > 0 )); then
        days="-${days}"
    fi

    find -H "$PWD" \
         -maxdepth 1 \
         -xtype f \
         -daystart \
         -mtime "$days" \
         -print
}

# find a file whose name contains a given string
ff() { _z_find file "$PWD" "$@"; }

# find a directory whose name contains a given string
fd() { _z_find dir "$PWD" "$@"; }

# list all files under $PWD changed today
today() { _z_find_daysold 0; }

# list all files under $PWD changed this week
thisweek() { _z_find_daysold -7; }
