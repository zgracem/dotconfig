# -----------------------------------------------------------------------------
# ~zozo/.config/bash/functions
# say hello: printf "zozo\x40inescapable\x2eorg"
# -----------------------------------------------------------------------------

quiet()
{   # execute a command silently
    "$@" >/dev/null 2>&1
}

_inPath()
{   # exits 0 if $1 is installed in $PATH
    quiet builtin type -P "$1"
}

_isGNU()
{   # exits 0 if $1 uses GNU switches
    quiet command "$1" --version
}

_isFunction()
{   # exits 0 if $1 is defined as a function
    quiet declare -f "$1"
}

_isAlias()
{   # exits 0 if $1 is defined as an alias
    quiet builtin alias "$1"
}

getPath()
{   # returns the full path to $1
    builtin type -P "$1" 2>/dev/null
}

getGNU()
{   # return the path to the GNU version of $1, if available
    declare bin="$1"

    if _isGNU "$bin"; then
        type -P "$bin"
    else
        getPath "g$bin"
    fi
}

scold()
{   # echo to standard error
    # Usage: scold [source] "message"

    printf "%b\n" >&2 "${2+$1: }${2-$1}"
}

# -----------------------------------------------------------------------------
# separate function files
# -----------------------------------------------------------------------------

_source $dir_config/bash/functions/*.bash
