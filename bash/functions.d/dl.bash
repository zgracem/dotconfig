if _inPath wget; then
    # download a file
    dl()      { wget "$@"; }

    # get HTTP headers
    headers() { wget --spider -Snv "$@"; }
else
    dl()      { curl -OJ "$@"; }
    headers() { curl -Is "$@"; }
fi
