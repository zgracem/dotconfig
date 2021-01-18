set -gx PAGER less
set -gx MANPAGER $PAGER

if command -sq mandb
    # don't let man-db use grotty to output SGR codes (preserves colour)
    set -gx GROFF_NO_SGR 1
    # use less's default prompt in man pages
    set -gx MANLESS
end
