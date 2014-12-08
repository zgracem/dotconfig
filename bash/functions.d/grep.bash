g()
{   # search files in the current directory (case-insensitive)
    grep -ni "$@" *
}

gg()
{   # search files in the current directory & recurse
    grep -niR "$@" *
}
