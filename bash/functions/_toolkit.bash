# ------------------------------------------------------------------------------
# ~zozo/.config/bash/functions/_toolkit.bash
# general utilities &c.
# ------------------------------------------------------------------------------

declare -xa theseFunctions=(
    _inPath
    _isFunction
    _isGNU
    getPath
    getGNU
    maketmp
    _t
)

# ------------------------------------------------------------------------------

_inPath()
{   # exits 0 if $1 is installed in $PATH
    builtin type -P "$1" &>/dev/null
}

_isFunction()
{   # exits 0 if $1 is defined as a function
    builtin declare -f "$1" &>/dev/null
}

_isGNU()
{   # exits 0 if $1 uses GNU switches
    "$(getPath "$1")" --version &>/dev/null
}

getPath()
{   # returns the full path to $1
    declare bin

    bin=$(builtin type -P "$1" 2>/dev/null) ||
        return 1

    printf "%s" "$bin"
}

getGNU()
{   # return the path to the GNU version of $1, if available
    declare bin

    bin="$(getPath $1)" || return 1

    _isGNU "$bin" || {
        bin="$(getPath g$1)" || return 1
    }

    printf -v bin "%s" "$bin"

    echo "$bin"
}

maketmp()
{   # GNU/BSD agnostic tempdir function
    declare defaultTemplate="${this:-$0}.$$"

    # for GNU
    _isGNU mktemp &&
        defaultTemplate+='.XXXXXX'

    declare template="${1:-$defaultTemplate}"

    command mktemp -d -q -t "${1:-$template}" ||
        return 1
}

_t()
{   # mimic ternary operator -- (expr ? ifTrue : ifFalse)
    # Usage: _t 'expr' ifTrue ifFalse

    [[ $# -ne 3 ]] && {
        printf "%s: syntax error\n" $FUNCNAME 1>&2
        return 1
    }

    [[ $1 ]] && {
        echo "$2"
    } || {
        echo "$3"
    }
}

# -----------------------------------------------------------------------------

export -f ${theseFunctions[@]}
