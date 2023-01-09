# Source: https://stackoverflow.com/a/15984450
function un1c -d "Count unique lines in FILE or stdin"
    if set -q argv[1]
        sort $argv[1]
    else
        cat | sort
    end \
    | uniq -c \
    | sort -bgr
end
