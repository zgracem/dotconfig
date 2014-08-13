# -----------------------------------------------------------------------------
# ~zozo/.config/bash/functions/images.bash
# -----------------------------------------------------------------------------

getProperty()
{   # wrapper for sips to strip all the non-property output
    # Usage: getProperty PROPERTY FILE

    declare property="$1" file="$2"

    sips --getProperty $property "$file" |
        sed -nE "s%^[[:space:]]+$property: (.+)\$%\\1%p"
}

dim()
{   # return image dimensions
    if [[ $# -eq 0 ]]; then
        printf "Usage: %s image ...\n" $FUNCNAME 1>&2
        return 1
    fi

    declare img width height
    for img in "$@"; do
        if getProperty format "$img" 2>&1 | grep -q '^Error'; then
            scold "$img: Not an image file"
        else
            printf "%s: " "${img##*/}"

            sips --getProperty pixelWidth --getProperty pixelHeight "$img" |
            sed -nzE 's/^.*pixelWidth: ([[:digit:]]+)\n.*pixelHeight: ([[:digit:]]+)/\1 × \2/p'
        fi
    done
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
