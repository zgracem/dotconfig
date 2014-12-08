dim()
{   # return image dimensions
    if [[ $# -eq 0 ]]; then
        scold "Usage: ${FUNCNAME} IMAGE ..."
        return 64
    fi

    local -a images=("$@")
    local image
    local error

    local dim_regex='([[:digit:]]+) x ([[:digit:]]+)'

    for image in "${images[@]}"; do
        local info
        read  info < <(file -bp "$image")

        if [[ $info =~ "image data" ]]; then
            local width= height=

            if _inPath sips; then
                read width  < <(getProperty pixelWidth  "$image")
                read height < <(getProperty pixelHeight "$image")
            elif [[ $info =~ $dim_regex ]]; then
                width="${BASH_REMATCH[1]}"
                height="${BASH_REMATCH[2]}"
            fi

            if [[ -n $width && -n $height ]]; then
                echo "${image}: ${width} × ${height}"
            else
                scold "${image}: could not get dimensions"
                error=true
            fi
        else
            scold "${image}: not an image file"
            error=true
        fi
    done

    if [[ $error == true ]]; then
        return 1
    else
        return 0
    fi
}
