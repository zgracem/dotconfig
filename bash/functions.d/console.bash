if ! [[ -r /var/log/system.log ]]; then
    return
fi

console()
{   # scan system messages from Terminal
    # http://brettterpstra.com/a-simple-but-handy-bash-function-console/

    if [[ $# > 0 ]]; then
        local query=$(echo "$*" | tr -s ' ' '|')
        tail -f /var/log/system.log \
        | grep -i "$query"
    else
        tail -f /var/log/system.log
    fi
}
