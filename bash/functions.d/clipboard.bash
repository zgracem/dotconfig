pbmarkdown()
{   # convert clipboard contents to Markdown

    pbpaste \
    | ~/bin/Markdown.pl \
    | pbcopy
}

pbsort()
{   # sort contents of clipboard

    pbpaste \
    | sort -u \
    | pbcopy
}

cppwd()
{   # copy current directory's path to clipboard

    printf "%q" "$PWD" \
    | pbcopy
}

# -----------------------------------------------------------------------------

_inPath cygpath || return

cpcd()
{   # copy current directory's Windows path to clipboard

    cygpath -aw "$PWD" \
    | tr -d '\n' \
    | pbcopy
}
