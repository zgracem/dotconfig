[[ $OSTYPE =~ darwin ]] || return

sp()
{   # find a file using Spotlight
    local scope="$PWD"
    local query="$@"

    mdfind -onlyin "$scope" -name "$query" \
    | grep -i "$query"
}

spliteral()
{   # interpret search query as though it had been typed into the Spotlight menu
    local scope="$PWD"
    local query="$@"

    mdfind -onlyin "$scope" -interpret "$query" \
    | grep -i "$query"
}
