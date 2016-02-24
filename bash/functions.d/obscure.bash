obscure()
{
    local instring="${@:-$(</dev/stdin)}"

    local i
    local inchar outchar url outstring

    for (( i = 0; i < ${#instring}; i++ )); do
        inchar="${instring:$i:1}"

        case ${FUNCNAME[1]} in
            obscure_url)
                printf -v outchar '%%%02x' "'${instring:$i:1}"
                ;;
            obscure_html)
                printf -v outchar "&#x%02x;" "'${instring:$i:1}"
                ;;
        esac

        outstring+="$outchar"
    done

    echo "$outstring"
}

obscure_url() { obscure "$@"; }
obscure_html() { obscure "$@"; }

obscure_unicode()
{
    <<< "${@:-$(</dev/stdin)}" \
    sed "y/ABCDEHIJKLMNOPSTXYZacdeijlmopsvxy/ΑΒСⅮΕΗΙЈΚⅬΜΝΟΡЅΤΧΥΖасⅾеіјⅼⅿοрѕⅴху/"
}
