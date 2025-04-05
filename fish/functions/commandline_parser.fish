function commandline_parser
    set -l joint " ‡ "
    echo
    echo "current-buffer:  "(commandline -b)
    echo "current-job:     "(commandline -j)
    echo "current-process: "(commandline -p)
    echo "current-token:   "(commandline -t)
    echo "cut-at-cursor:   "(commandline -c)
    echo "tokens-expanded: "(commandline -x | string join $joint)
    echo "tokens-raw:      "(commandline --tokens-raw | string join $joint)
end
