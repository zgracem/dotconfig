# ------------------------------------------------------------------------------
# ~zozo/.config/bash/functions/images.bash
# ------------------------------------------------------------------------------

dim()
{   # return image dimensions
    if [[ $# -eq 0 ]]; then
        printf "Usage: %s image ...\n" $FUNCNAME 1>&2
        return 1
    fi

    declare img width height
    for img in "$@"; do
        if sips --getProperty format "$img" 2>&1 | grep ^Error &>/dev/null; then
            printf "%s: Not an image file\n" "$img"
        else
            width=$(sips --getProperty pixelWidth "$img" | grep pixelWidth: | awk '{ print $2 }')
            height=$(sips --getProperty pixelHeight "$img" | grep pixelHeight: | awk '{ print $2 }')
            printf "%s: %s × %s\n" "${img##*/}" $width $height
        fi
    done
}

optim()
{   # optimize png/gif/jpg files
    open -a $HOME/Applications/ImageOptim.app "$@"
}
