function _my_ip --description 'Display current public IP address'
    curl -sS \
        -H "Accept: application/json" \
        -H "Authorization: Bearer $IPINFO_TOKEN" \
        "https://ipinfo.io" \
        | jq -r .ip
end
