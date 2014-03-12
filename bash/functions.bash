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

z_require()
{   # specify dependencies (OS, apps, GNU versions of apps, or directories) and
    # return false if they don't exist

    declare usage="$FUNCNAME [-a APPLICATION] [-d DIR] [-f FILE] [-g GNU_APP] [-o OS]"
    declare OPTIND OPTARG option object error

    while getopts ':a:d:f:g:o:' option; do
        unset object

        case $option in
            a)
                _inPath "$OPTARG" || object="application: $OPTARG"
                ;;
            d)
                [[ -d "$OPTARG" ]] || object="directory: $OPTARG"
                ;;
            f)
                [[ -f "$OPTARG" ]] || object="file: $OPTARG"
                ;;
            g)
                getGNU "$OPTARG" &>/dev/null || object="application: GNU $OPTARG"
                ;;
            o)
                [[ $OSTYPE =~ "$OPTARG" ]] || {
                    scold "not supported on this OS"
                    return 1
                }
            ;;
            *)
                scold "Usage: $usage"
                return 64
                ;;
        esac

    [[ $object ]] && {
        scold "missing required $object"
        error=true
    }
    done

    if [[ $error ]]; then
        return 69
    else
        return 0
    fi
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

    declare func="$1" source{,File,Line}

    declare -f "$func" &>/dev/null || {
        printf "%s: %s: function not defined\n" "$FUNCNAME" "$func" 1>&2
        return 1
    }

    source="$(where "$func" | colourstrip)"
    sourceFile="${source%:*}"
    sourceLine="${source#*:}"

    _edit "${sourceFile/#~/$HOME}@${sourceLine}"
}

