md5check()
{   # quickly verify MD5 checksums

    local checksum="$1" file="$2"

    if (( $# != 2 )); then
        scold "Usage: $FUNCNAME checksum file"
        return 1
    fi

    md5sum -c <<< "$checksum $file"
}
