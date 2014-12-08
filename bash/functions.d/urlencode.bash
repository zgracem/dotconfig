urlencode()
{   # pure bash URL-encoding
    # Based on: http://stackoverflow.com/a/10660730

    local instring="$1" outstring
    local inchar outchar
    local i

    for (( i = 0; i < ${#1}; i++ )); do
        inchar="${instring:$i:1}"

        case $inchar in
            [-_.~a-zA-Z0-9])
                outchar="$inchar"
                ;;
            *)
                printf -v outchar '%%%02x' "'$inchar"
                ;;
        esac

        outstring+="$outchar"
    done

    echo "$outstring"
}

urldecode()
{   # corresponding decode function
    # http://stackoverflow.com/a/10660730

    printf '%b' "${@//%/\\x}"
    z_newline
}

# TODO: turn into shell script
urlEncodeFile()
{   # URL-encode an entire file; http://stackoverflow.com/a/10797966
    declare targetFile="$1"

    command curl -q \
        --silent \
        --output /dev/null \
        --get --data-urlencode "$(cat "$targetFile")" \
        --write-out %{url_effective} \
        "" \
    | cut -c 3-
}
