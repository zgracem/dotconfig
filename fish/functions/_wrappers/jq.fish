in-path jq; or exit

function jq -d "Command-line JSON processor"
    # Search this path for modules instead of ~/.jq
    set -p argv -L$XDG_DATA_HOME/jq

    command jq $argv
end
