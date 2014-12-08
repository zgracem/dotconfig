md5check()
{   # quickly verify MD5 checksums
    # Usage: md5check CHECKSUM FILE

    local checksum="$1" file="$2"
    local regex='[[:xdigit:]]{32}'

    if ! [[ $# -eq 2 ]]; then
        scold "Usage: $FUNCNAME CHECKSUM FILE"
        return 1
    fi

    if ! [[ $checksum =~ $regex ]]; then
        scold "$FUNCNAME: $checksum: invalid checksum"
        return 65
    fi

    if ! [[ -r $file ]]; then
        scold "$FUNCNAME: $file: invalid file"
        return 66
    fi

    printf "%s %s" $checksum "$file" \
    | md5sum -c
}
