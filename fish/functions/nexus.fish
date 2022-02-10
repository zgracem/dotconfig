function nexus
    set -l route $argv[1]
    curl -sS --header "apikey: $NEXUS_API_KEY" https://api.nexusmods.com$route
end
