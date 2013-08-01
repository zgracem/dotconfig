# ------------------------------------------------------------------------------
# ~zozo/.config/bash/functions/search.bash
# ------------------------------------------------------------------------------

g()
{   # search files in the current directory
    grep -inI "$@" *
    # --ignore-case --line-number --binary-files=without-match
}

gg()
{   # search files in the current directory & recurse
    grep -inIR "$@" *
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
