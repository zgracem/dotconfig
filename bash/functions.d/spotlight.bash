_inPath mdfind || return

sp()
{   # find a file using Spotlight
    local scope="$PWD"
    local term="$@"

    mdfind -onlyin "$scope" -name "$term" \
    | grep -i "$term"
}

spliteral()
{   # interpret search term as though it had been typed into the Spotlight menu
    local term="$@"

    mdfind -interpret "$term" \
    | grep -i "$term"
}
