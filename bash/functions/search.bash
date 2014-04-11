# ------------------------------------------------------------------------------
# ~zozo/.config/bash/functions/search.bash
# ------------------------------------------------------------------------------

g()
{   # search files in the current directory (-i = case-insensitive)
    grep -i --line-number "$@" *
}

gg()
{   # search files in the current directory & recurse
    grep -i --line-number --recursive "$@" *
}

ff()
{   # find a file whose name contains a given string
    declare scope="$PWD" term="$@"

    find -H "$scope" -type f -iname '*'$term'*' 2>&- |
    sed "s|^$HOME|~|g" |
    grep -i "$term"
}

_inPath mdfind && {
    sp()
    {   # find a file using Spotlight
        declare scope="$PWD" term="$@"

        mdfind -onlyin "$scope" -name "$term" |
        grep -i "$term"
    }
}
