go()
{
    declare name="$1" place checkvar child
    declare alias_file="${dir_config}/bash/places/go_aliases"

    if [[ $name =~ / ]]; then
        child="${name#*/}"
        name="${name%%/*}"
    fi

    # first, see if we're trying to call a variable directly
    checkvar="dir_${name}"

    if [[ -n ${!checkvar} ]]; then
        place="${!checkvar}"
    else
        # see if there's an alias with that name
        place="$(sed -nE "s/^${name}\t(.+)$/\1/p" "$alias_file")"
        eval "place=\"${place}\""
    fi

    # any luck?
    if [[ -z $place ]]; then
        scold "${FUNCNAME}: ${name}: not found"
        return 1
    fi

    # make sure that directory exists & is accessible
    if [[ ! -d $place ]]; then
        scold "${FUNCNAME}: ${place}: not a directory"
        return 1
    elif [[ ! -r $place ]]; then
        scold "${FUNCNAME}: ${place}: not readable"
        return 1
    else
        cd "${place}${child:+/$child}"
    fi
}

