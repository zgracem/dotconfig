escape()
{   # escape UTF-8 characters into their three-byte format
    # https://github.com/mathiasbynens/dotfiles/blob/master/.functions

    printf "\\\x%s" $(tr -d '\n' <<< "$@" | xxd -p -c1 -u)
    printf '\n'
}
