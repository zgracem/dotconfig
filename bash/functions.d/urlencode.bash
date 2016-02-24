urlencode()
{   # pure bash URL-encoding
    # Based on: http://stackoverflow.com/a/10660730

    local instring="${@:-$(</dev/stdin)}"

    local outstring
    local inchar outchar
    local i

    for (( i = 0; i < ${#instring}; i++ )); do
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

    local instring="${@:-$(</dev/stdin)}"
    local outstring="${instring//%/\\x}"

    echo -e "$outstring"
}
