# -----------------------------------------------------------------------------
# ~zozo/.config/bash/functions/images.bash
# -----------------------------------------------------------------------------

dim()
{   # return image dimensions
    if [[ $# -eq 0 ]]; then
        printf "Usage: %s image ...\n" $FUNCNAME 1>&2
        return 1
    fi

    declare img width height
    for img in "$@"; do
        if sips --getProperty format "$img" 2>&1 | grep -q '^Error'; then
            printf "%s: Not an image file\n" "$img"
        else
            printf "%s: " "${img##*/}"

            sips --getProperty pixelWidth --getProperty pixelHeight "$img" |
            sed -nzE 's/^.*pixelWidth: ([[:digit:]]+)\n.*pixelHeight: ([[:digit:]]+)/\1 × \2/p'
        fi
    done
}
