abs()
{   # return the absolute value of a number
    [[ $# -eq 1 && $1 =~ $digitRegex ]] || return 1

    declare x="$1"

    [[ $x -lt 0 ]] && x=$((-x))

    echo $x
}


hex2bin()
{
    echo "obase=2; ibase=16; ${1^^}" | bc
}

bin2hex()
{
    echo "obase=16; ibase=2; $1" | bc
}

