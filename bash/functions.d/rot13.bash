rot13()
{   # translate text to or from ROT13
    declare mask='a-zA-Z n-za-mN-ZA-M'

    if [[ -f $1 ]]; then
        # file
        tr $mask < "$1"
    elif [[ -t 0 ]]; then
        # string
        echo "$1" | tr $mask
    else
        # standard input
        tr $mask
    fi
}
