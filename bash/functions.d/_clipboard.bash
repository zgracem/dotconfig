pbwc()
{   # get word count of clipboard contents

    pbpaste \
    | wc -w
}

pbsort()
{   # sort contents of clipboard

    # add a newline to the end for sorting purposes
    (pbpaste;echo) \
    | sort -u \
    | pbcopy

    ### ZGM removed `uniq` call 2016-06-04 -- necessary?
}

cppwd()
{   # copy current directory's path to clipboard

    pbcopy <<< "$PWD"
}

[[ $OSTYPE =~ cygwin ]] || return

cpcd()
{   # copy current directory's Windows path to clipboard

    cygpath -aw "$PWD" \
    | tr -d '\n' \
    | pbcopy
}
