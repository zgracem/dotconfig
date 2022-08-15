function __fish_complete_ncurses_binary
    set -l formats \
        "1,hexadecimal" \
        "2,base64" \
        "3,hex+base64"

    string replace ',' \t $formats
end
