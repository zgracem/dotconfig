random_filename()
{   # generate a random filename
    # Based on: http://brettterpstra.com/2014/06/09/even-better-random-filenames/
    _inPath aspell || return

    local num_words="${1-2}"
    local -a words

    words=( $(aspell dump master \
    | command grep -E "^[[:alpha:]]{3,10}\$" \
    | shuf -n $num_words ) )

    local output="${words[@]}"
    output="${output// /-}"

    echo "$output"
}
