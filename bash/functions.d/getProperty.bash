_inPath sips || return

getProperty()
{   # wrapper for sips to strip all the non-property output
    # Usage: getProperty PROPERTY FILE

    local property="$1" file="$2"

    sips --getProperty $property "$file" \
    | sed -nE "s%^[[:space:]]+$property: (.+)\$%\\1%p"
}
