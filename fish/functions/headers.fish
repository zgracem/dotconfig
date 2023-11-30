function headers -d "Print HTTP response headers for a URL"
    argparse -xw,c w/wget c/curl -- $argv
    or return

    set -l wget_args --server-response --spider --no-verbose
    set -l curl_args --head --silent --show-error

    if set -q _flag_wget
        wget $wget_args $argv
    else if set -q _flag_curl
        curl $curl_args $argv
    else if in-path wget
        wget $wget_args $argv
    else if in-path curl
        curl $curl_args $argv
    end
end
