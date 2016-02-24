_inPath keybase || return

encrypt()
{   # encrypt a file for my own use
    local input output

    for input in "$@"; do
        output="${input}.asc"

        keybase encrypt zozo < "$input" > "$output" \
            && echo "Encrypted $output"
    done
}

decrypt()
{   # corresponding decrypt function
    local input output

    for input in "$@"; do
        output="${input%.asc}"

        keybase decrypt "$input" > "$output" \
            && echo "Decrypted $output"
    done
}
