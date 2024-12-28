function my --description 'Display network information'
    set -l commands ip localip router ssid

    switch "$argv[1]"
        case ip
            curl -sS \
                -H "Accept: application/json" \
                -H "Authorization: Bearer $IPINFO_TOKEN" \
                "https://ipinfo.io" \
                | jq -r .ip

        case localip
            if is-macos
                set -l pattern '^.*Setup:/Network/Interface/(en\d)/AirPort$'
                set -l netcard (echo list | scutil | string match -rg $pattern)
                and ipconfig getifaddr $netcard
            else if is-cygwin
                set -l pattern '.*IPv4 Address.*: ([\d.]+).*'
                ipconfig | string match -rg $pattern
            end

        case router
            if command -q netstat
                netstat -rn | string match -rg '^(?:default|0\.0\.0\.0) +([\d.]+).*$'
            else if is-cygwin
                ipconfig | string match -rg '.*Default Gateway.*: ([\d.]+).*'
            else
                return 127
            end

        case ssid
            if is-macos; and command -q airport
                airport --getinfo 2>/dev/null | string match -rg '.*\bSSID: (.+)$'
            else
                return 127
            end

        case ''
            echo "Public IP:" (my ip; or echo n/a)
            echo " Local IP:" (my localip; or echo n/a)
            echo "Router IP:" (my router; or echo n/a)
            echo "     SSID:" (my ssid; or echo n/a)

        case '*'
            echo >&2 "error: don't know about your $argv[1]"
            return 1
    end
end
