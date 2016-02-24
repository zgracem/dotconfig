dim()
{   # get image dimensions

    if [[ -z $1 ]]; then
        scold "Usage: ${FUNCNAME[0]} file ..."
        return $EX_USAGE
    fi

    local re_file='[[:upper:]]+ image data, '
    local re_sips='pixelWidth: ([[:digit:]]+)[[:space:]]+pixelHeight: ([[:digit:]]+)'
    local re_dims='([[:digit:]]+) x ([[:digit:]]+)'

    local image info width height

    for image in "$@"; do
        info=$(command file -bp "$image" 2>/dev/null)

        if [[ $info =~ $re_file ]]; then
            if [[ $info =~ $re_dims ]]; then
                width=${BASH_REMATCH[1]}
                height=${BASH_REMATCH[2]}
            elif _inPath sips; then
                info=$(command sips -g pixelWidth -g pixelHeight "$1" 2>&1)

                if [[ $info =~ $re_sips ]]; then
                    width=${BASH_REMATCH[1]}
                    height=${BASH_REMATCH[2]}
                fi
            fi
        else
            scold "${image}: not an image file"
            return $EX_DATAERR
        fi

        if [[ -n $width && -n $height ]]; then
            printf '%d \xC3\x97 %d\n' "$width" "$height"
            return 0
        else
            scold "${image}: could not get dimensions"
            return $EX_SOFTWARE
        fi
    done
}

