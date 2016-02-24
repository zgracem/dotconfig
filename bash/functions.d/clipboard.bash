pbwc()
{   # get word count of clipboard contents

    pbpaste \
    | wc -w
}

pbsort()
{   # sort contents of clipboard

    pbpaste \
    | sort \
    | uniq \
    | pbcopy
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
