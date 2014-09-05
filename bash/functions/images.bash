# -----------------------------------------------------------------------------
# ~zozo/.config/bash/functions/images.bash
# -----------------------------------------------------------------------------

getProperty()
{   # wrapper for sips to strip all the non-property output
    # Usage: getProperty PROPERTY FILE

    declare property="$1" file="$2"

    sips --getProperty $property "$file" \
    | sed -nE "s%^[[:space:]]+$property: (.+)\$%\\1%p"
}

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

maxWidth()
{   # resize image $1 to $2 pixels wide
    
    declare imageFile="$1" newWidth="$2" newHeight
    declare originalWidth originalHeight aspectRatio

    # get current width and height
    originalWidth=$(getProperty pixelWidth "$imageFile")
    originalHeight=$(getProperty pixelHeight "$imageFile")

    # calculate aspect ratio
    aspectRatio=$(calc "scale=3;$originalWidth/$originalHeight")

    # calculate new height
    newHeight=$(calc "scale=0;$newWidth/$aspectRatio")

    # resize image
    quietly /usr/bin/sips -z $newHeight $newWidth "$imageFile"
}
