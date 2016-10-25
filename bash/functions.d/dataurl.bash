dataurl()
{   # create a data URL from an image
    # >> https://github.com/mathiasbynens/dotfiles/blob/master/.functions

    if (( $# != 1 )); then
        scold "Usage: ${FUNCNAME[0]} IMAGE"
        return 1
    elif [[ ! -f $1 ]]; then
        scold "file not found: $1"
        return 1
    fi

    local img="$1"
    local ext="${img##*.}"
    local b64

    if b64=$(openssl base64 -in "$img" | tr -d '\n'); then
        printf 'data:image/%s;base64,%s\n' "$ext" "$b64"
    fi
}
