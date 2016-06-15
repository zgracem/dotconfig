g2()
{
    local name="$1" place

    if [[ $name =~ / ]]; then
        local child="${name#*/}"
        name="${name%%/*}"
    fi

    # remove illegal characters or ${!checkvar} expansion below will fail
    local checkvar="dir_${name//[^[:alnum:]_]}"

    # first, see if we're trying to call a variable directly
    if [[ -n ${!checkvar} ]]; then
        place="${!checkvar}${child:+/$child}"
    # maybe it's a directory in $HOME?
    elif [[ -d $HOME/$name${child:+/$child} ]]; then
        place="$HOME/$name${child:+/$child}"
    elif [[ -n $DIRSTACK ]]; then
        local re="$name"'$'
        local d; for d in "${DIRSTACK[@]}"; do
            if [[ $d =~ $re ]]; then
                place="${d/#~/$HOME}${child:+/$child}"
            fi
        done
    fi

    # any luck?
    if [[ -d $place ]]; then
        cd "$place"
    else
        scold "$FUNCNAME: $1: not found"
        return 1
    fi
}
