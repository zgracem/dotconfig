qg()
{   # return the first Google result for $1

    if [[ -n $QG_ID && -n $GOOGLE_API_KEY ]]; then
        local term=$@
        local term_esc
        term_esc=$(urlencode "$term")
    else
        scold 'Error: Google API information not found in environment'
        return 1
    fi

    local referer='http://inescapable.org/qg'
    local options='fields=items(link)&prettyPrint=false'
    local query

    query+='https://www.googleapis.com/customsearch/v1'
    query+="?key=$GOOGLE_API_KEY"
    query+="&cx=$QG_ID"
    query+="&$options"
    query+="&q=$term_esc"

    local url
    url=$(curl -sS --referer "$referer" "$query" \
        | jq -r .items[0].link)

    if [[ -n $url && ! $url =~ ^null ]]; then
        echo "$url"
    else
        scold "$FUNCNAME: $term: not found"
        return 1
    fi
}

qgo()
{
    local url

    if url="$(qg "$@")"; then
        "$BROWSER" "$url"
    else
        return
    fi
}
