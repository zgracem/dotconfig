function xpt
    function _curl
        set -p argv -qsS --connect-timeout=10
        echo >&2 "curl $argv"
        curl $argv
    end

    set -l server "http://10.0.0.201"
    set -l json -H "Content-Type: application/json"

    switch $argv[1]
        case status
            _curl "$server/api/status" | jq .
        case files
            _curl "$server/api/files?path=$argv[2]" | jq .
        case download # path
            set -q argv[2]; or return 2
            _curl -OJ "$server/download?path=$argv[2]"
        case upload # file path
            set -q argv[2]; or return 2
            _curl -X POST -F "file=@$argv[2]" "$server/upload?path=$argv[3]"
        case mkdir # name [path]
            set -q argv[2]; or return 2
            _curl -X POST -d "name=$argv[2]" -d"path="$argv[3] "$server/mkdir"
        case rename # path name
            set -q argv[2] argv[3]; or return 2
            _curl -X POST -d "path=$argv[2]" -d "name=$argv[3]" "$server/rename"
        case move # path dest
            set -q argv[2] argv[3]; or return 2
            _curl -X POST -d "path=$argv[2]" -d "dest=$argv[3]" "$server/move"
        case delete # path [path ...]
            set -q argv[2]; or return 2
            set -l paths (string join , \"$argv[2..]\")
            _curl -X POST -d "paths=[$paths]" "$server/delete"
        case get-settings
            _curl "$server/api/settings" | jq .
        case post-settings # key value
            set -q argv[2] argv[3]; or return 2
            _curl -X POST $json -d '{"'$argv[2]'":'$argv[3]'}' "$server/api/settings"
        case get-fonts
            _curl "$server/api/fonts" | jq .
        case upload-font # family file
            set -q argv[2] argv[3]; or return 2
            _curl -X POST -F "family=$argv[2]" -F "file=@$argv[3]" "$server/api/fonts/upload" | jq .
        case delete-font # family
            set -q argv[2]; or return 2
            _curl -X POST $json -d '{"family":"'$argv[2]'"}' "$server/api/fonts/delete" | jq .
        case get-opds
            _curl "$server/api/opds" | jq .
        # case post-opds
        #     # Include `index` to update an existing entry.
        #     _curl -X POST $json \
        #         -d '{"name":"My Catalog","url":"http://calibre.local:8080/opds","username":"reader","password":"secret"}' \
        #         "$server/api/opds"
        case get-wifi
            _curl "$server/api/wifi" | jq .
        # case post-wifi
        #     # Include `index` to update an existing entry. If `password` is omitted during an update, the existing password is preserved.
        #     _curl -X POST $json -d '{"ssid":"HomeWiFi","password":"secret"}' "$server/api/wifi"
        case delete-wifi # index
            set -q argv[2]; or return 2
            _curl -X POST $json -d '{"index":'$argv[2]'}' "$server/api/wifi/delete"
        case -h
            string match -rg "^\s+case ([^\"-].+?)(?= #|\$)" <(status filename)
        case --help
            string replace -rf '^\s*case ([^\"-].+?)(?: # (.+))?$' 'xpt \1 \U\2' <(status filename)
        case "*"
            return 2
    end
end
