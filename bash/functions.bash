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

_shoptSet()
{   # exits 0 if shell option $1 is set
    [[ $BASHOPTS =~ $1 ]]
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

for subFile in $dir_config/bash/functions/*; do
    _source "$subFile"
    [[ $theseFunctions ]] && {
        export -f ${theseFunctions[@]} &>/dev/null
        unset theseFunctions
    }
done

# -----------------------------------------------------------------------------

fe()
{   # find and edit a function
    [[ $# -eq 1 ]] || return 1

    declare func="$1" sourceFile

    declare -f "$func" &>/dev/null || {
        printf "%s: %s: function not defined\n" "$FUNCNAME" "$func" 1>&2
        return 1
    }

    sourceFile="$(where "$func" | colourstrip | cut -d: -f1)"

    _edit "${sourceFile/#~/$HOME}"
}

