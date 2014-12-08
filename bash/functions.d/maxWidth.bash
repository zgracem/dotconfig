_inPath sips || return
_isFunction getProperty || return
_isFunction calc || return

maxWidth()
{   # resize image $1 to $2 pixels wide

    local file="$1"
    local new_width="$2" new_height
    local old_width old_height ratio

    # get current width and height
    old_width=$(getProperty pixelWidth "$file")
    old_height=$(getProperty pixelHeight "$file")

    # calculate aspect ratio
    ratio=$(calc "scale=3;$old_width/$old_height")

    # calculate new height
    new_height=$(calc "scale=0;$new_width/$ratio")

    # resize image
    quietly /usr/bin/sips -z $new_height $new_width "$file"
}
