export PAGER=less
export MANPAGER=$PAGER

if command -v mandb >/dev/null; then
  # don't let man-db use grotty to output SGR codes (preserves colour)
  export GROFF_NO_SGR=1
  # use less's default prompt in man pages
  export MANLESS=""
fi
