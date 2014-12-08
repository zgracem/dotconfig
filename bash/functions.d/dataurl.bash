dataurl()
{   # create a data URL from an image
    # https://github.com/mathiasbynens/dotfiles/blob/master/.functions

    echo "data:image/${1##*.};base64,$(openssl base64 -in "$1")" \
    | tr -d "\n"
    z_newline
}
