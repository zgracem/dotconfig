escape()
{   # escape UTF-8 characters into their three-byte format
    # https://github.com/mathiasbynens/dotfiles/blob/master/.functions

    printf "\\\x%s" $(printf "$@" | xxd -p -c1 -u)
    z_newline
}
