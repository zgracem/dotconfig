auc::url()
{
    local document="$1"
    local regex='^((U|DA)?([[:digit:]]{4})-[[:digit:]]+$|[[:digit:]]+-D[[:digit:]]+-([[:digit:]]{4}))$'
    auc_url='http://www.auc.ab.ca/applications/'

    if [[ -z $document ]]; then
        read document < /dev/clipboard
    fi

    if [[ $document =~ $regex ]]; then
        local year="${BASH_REMATCH[3]}${BASH_REMATCH[4]}"
    else
        scold "$FUNCNAME: invalid document number: $document"
        return 1
    fi

    case $document in
        U*) # utility order
            auc_url+='orders/utility-orders/Utility%20Orders'
            ;;
        *)  # decision
            auc_url+='decisions/Decisions'
            ;;
    esac

    auc_url+="/$year/$document.pdf"

    printf '%s' "$auc_url"
}

auc()
{
    local auc_url

    if auc_url=$(auc::url "$1"); then
        "$BROWSER" "$auc_url"
    else
        return
    fi
}

# makelink()
# {
#     local link document hyperlink auc_url
#     read  link < <(/bin/getclip)

#     if [[ $link =~ ^http://www.auc.ab.ca ]]; then
#         document="${link##*/}"
#         document="${document%.*}"
#     elif auc_url=$(auc::url "$link"); then
#         document="$link"
#         link="$auc_url"
#     else
#         scold "$FUNCNAME: error: no valid document or link in clipboard"
#         return 1
#     fi

#     hyperlink="=HYPERLINK(\"$link\",\"${document}\")"

#     /bin/putclip <<< "$hyperlink"
# }
