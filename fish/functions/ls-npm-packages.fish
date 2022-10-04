function ls-npm-packages --description "List all globally installed npm packages"
    npm ls --global --depth=0 --json \
        | jq --raw-output '.dependencies | to_entries | map("\(.key)@\(.value.version)") | .[]'
end
