explode()
{   # expands and displays an array

    local func=${FUNCNAME[1]:-${FUNCNAME[0]}}

    if (( $# == 1 )); then
        local array=$1
        local declaration=$(declare -p $array 2>&1)
        local error
    else
        z::print "${z_no}${func}${z0}: syntax error\n" >&2
        z::print "Usage: ${func} ARRAY\n" >&2
        return 1
    fi

    case $declaration in
        declare\ -[aA]*)
            local temp_array key

            # transfer it to our own array
            eval "${declaration/ $array=/ temp_array=}"

            for key in ${!temp_array[*]}; do
                printf '[%s]=%s\n' "$key" "${temp_array[$key]}"
            done

            return 0
            ;;
        declare*)    error='not an array' ;;
        *not\ found) error='not found' ;;
        *)           error=${declaration#bash: declare: } ;;
    esac

    z::print "${z_no}${func}${z0}: ${array}: ${error}\n" >&2
    return 1
}

