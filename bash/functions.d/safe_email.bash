safe_email()
{
    local instring="${@:-$(</dev/stdin)}"

    local i
    local inchar outchar url outstring

    # url-encode mailto: address
    for (( i = 0; i < ${#instring}; i++ )); do
        inchar="${instring:$i:1}"

        case $inchar in
            [a-zA-Z0-9])
                outchar="$inchar"
                ;;
            *)
                printf -v outchar '%%%02x' "'${instring:$i:1}"
                ;;
        esac

        url+="$outchar"
    done

    # HTML-entity-ify email address
    for (( i = 0; i < ${#instring}; i++ )); do
        inchar="${instring:$i:1}"

        case $inchar in
            [a-zA-Z0-9])
                outchar="$inchar"
                ;;
            *)
                printf -v outchar "&#x%02x;" "'${instring:$i:1}"
                ;;
        esac

        outstring+="$outchar"
    done

    printf '<a href="mailto:%s">%s</a>\n' "$url" "$outstring"
}
