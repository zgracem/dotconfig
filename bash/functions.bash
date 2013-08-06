# -----------------------------------------------------------------------------
# ~zozo/.config/bash/functions
# say hello: printf "zozo\x40inescapable\x2eorg"
# -----------------------------------------------------------------------------

for subFile in $dir_config/bash/functions/*; do
    _source "$subFile"
    [[ $theseFunctions ]] && {
        export -f ${theseFunctions[@]} &>/dev/null
        unset theseFunctions
    }
done

# -----------------------------------------------------------------------------
# misc.
# -----------------------------------------------------------------------------

fe()
{   # find and edit a function
    declare func="$1" sourceFile

    declare -f "$func" &>/dev/null || {
        printf "%s: %s: function not defined\n" "$FUNCNAME" "$func" 1>&2
        return 1
    }

    sourceFile="$(whichfunction "$func" | colourstrip | head -n1 | cut -d: -f1)"

    _edit "$sourceFile"
}

lesserOf()
{   # return the lesser of two numbers
    [[ $# -eq 2 ]] || return 1

    declare x="$1" y="$2" answer

    answer=$(( (x < y) ? x : y ))

    echo $answer
}

greaterOf()
{   # return the greater of two numbers
    [[ $# -eq 2 ]] || return 1

    declare x="$1" y="$2" answer

    answer=$(( (x > y) ? x : y ))

    echo $answer
}
