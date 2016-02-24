_isNumber()
{   # returns 0 if $1 is a valid number
    local digitRegex='^-?[[:digit:]]+$'
    [[ $1 =~ $digitRegex ]]
}


_isHex()
{   # returns 0 if $1 is a valid hexadecimal number
    local xdigitRegex='^(0x)?[[:xdigit:]]+$'
    [[ $1 =~ $xdigitRegex ]]
}

calc()
{
    bc -q 2>/dev/null <<< "$*"
}

min()
{   # return the smallest of a set of numbers
    local x min

    for x in "$@"; do
        : ${min:=$x}
        min=$(( (x < min) ? x : min ))
    done

    echo $min
}

max()
{   # return the largest of a set of numbers
    local x max

    for x in "$@"; do
        : ${max:=$x}
        max=$(( (x > max) ? x : max ))
    done

    echo $max
}

randInt()
{   # return a random integer within a range
    local int=-1 min max bound="$@"
    local regex='^([[:digit:]]+)?(-| )?([[:digit:]]+)?$'

    [[ $bound =~ $regex ]] || {
        scold "Usage: $FUNCNAME [MIN-][MAX]"
        return 1
    }

    [[ $bound =~ (-| ) ]] && {
        min="${bound%$BASH_REMATCH*}"
        max="${bound#*$BASH_REMATCH}"
    } || {
        max=$bound
    }

    : ${min:=0}
    : ${max:=32767}

    while [[ $int -lt $min ]]; do
        int=$(( RANDOM % (max + 1) ))
    done

    echo $int
}

coinflip()
{   # randomly returns 0 or 1
    return $(randInt 0-1)
}
