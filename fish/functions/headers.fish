function headers
    argparse -xw,c w/wget c/curl -- $argv
    or return

    if set -q _flag_wget
        _headers_wget $argv
    else if set -q _flag_curl
        _headers_curl $argv
    else if in-path wget
        _headers_wget $argv
    else if in-path curl
        _headers_curl $argv
    end
end

function _headers_wget
    wget --server-response --spider --no-verbose $argv
end

function _headers_curl
    curl --head --silent --show-error $argv
end
