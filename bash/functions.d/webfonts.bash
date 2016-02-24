webfonts()
{
    if [[ -x ~/src/github/css3FontConverter/convertFonts.sh ]]; then
        ~/src/github/css3FontConverter/convertFonts.sh --use-font-weight "$@" *.[ot]tf
    else
        local f; for f in "$@"; do # *.[ot]tf; do
            sfnt2woff-zopfli "$f" && woff2_compress "$f" && rm -f "$f"
        done
    fi
}
