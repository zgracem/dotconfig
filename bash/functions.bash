# -----------------------------------------------------------------------------
# ~zozo/.config/bash/functions
# say hello: printf "zozo\x40inescapable\x2eorg"
# -----------------------------------------------------------------------------

_inPath()
{   # exits 0 if $1 is installed in $PATH
    builtin type -P "$1" &>/dev/null
}

_isGNU()
{   # exits 0 if $1 uses GNU switches
    command "$1" --version &>/dev/null
}

_isFunction()
{   # exits 0 if $1 is defined as a function
    declare -f "$1" &>/dev/null
}

_isAlias()
{   # exits 0 if $1 is defined as an alias
    builtin alias "$1" &>/dev/null
}

getPath()
{   # returns the full path to $1
    builtin type -P "$1" 2>/dev/null
}

getGNU()
{   # return the path to the GNU version of $1, if available
    declare bin="$1"

    _isGNU "$bin" && {
        echo "$bin"
    } || {
        getPath "g$bin"
    }
}

scold()
{   # echo to standard error
    # Usage: scold [source] "message"

    printf "%b\n" >&2 "${2+$1: }${2-$1}"
}

# -----------------------------------------------------------------------------
# separate function files
# -----------------------------------------------------------------------------

for subFile in $dir_config/bash/functions/*.bash; do
    . "$subFile"
done

unset subFile

# -----------------------------------------------------------------------------

fe()
{   # find and edit a function
    [[ $# -eq 1 ]] || return 1

    declare func="$1" source{,File,Line}

    declare -f "$func" &>/dev/null || {
        scold "$FUNCNAME" "function not defined"
        return 1
    }

    source="$(where "$func" | colourstrip)"
    sourceFile="${source%:*}"
    sourceLine="${source#*:}"

    _edit "${sourceFile/#~/$HOME}@${sourceLine}"
}
