safe_email()
{
    declare input="$1" url string
    declare i inchar outchar

    # url-encode email address
    for (( i = 0; i < ${#input}; i++ )); do
        inchar="${input:$i:1}"

        case $inchar in
            [a-zA-Z0-9])
                outchar="$inchar"
                ;;
            *)
                printf -v outchar "%%%02x" "'${inchar}"
                ;;
        esac

        url+="$outchar"
    done

    # HTML-entity-ify same
    for (( i = 0; i < ${#input}; i++ )); do
        inchar="${input:$i:1}"

        case $inchar in
            [a-zA-Z0-9])
                outchar="$inchar"
                ;;
            *)
                printf -v outchar "&#x%02x;" "'${inchar}"
                ;;
        esac

        string+="$outchar"
    done

    # echo "<a href=\"mailto:${url}\">${string}</a>"

    printf '<a href="mailto:%s">%s</a>' "$url" "$string"
    z_newline
}
