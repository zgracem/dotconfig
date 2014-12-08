# set defaults
PAGER=less
MANPAGER=$PAGER

if _inPath mandb; then
    # don't let man-db use grotty to output SGR codes (preserves colour)
    export GROFF_NO_SGR=1

    # use less's default prompt in man pages
    export MANLESS=
fi

export PAGER MANPAGER
