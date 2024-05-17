function ls-npm --description "List all globally installed npm packages"
    for req in npm jq
        if not command -q $req
            echo >&2 "fatal error: this command requires `$req`"
            return 127
        end
    end

    npm ls --global --depth=0 --json \
        | jq --raw-output '.dependencies | to_entries | map("\(.key)@\(.value.version)") | .[]'
end
