pdfmarks()
{   # dump the titles of all bookmarks in a PDF
    # Requires: pdftk (https://www.pdflabs.com/tools/pdftk-the-pdf-toolkit/)
    # Usage: pdfmarks file.pdf
    _inPath pdftk || return

    local pdf="$1"

    pdftk "$pdf" dump_data output - \
    | sed -nE 's/^BookmarkTitle: (.+)$/\1/p' \
    | sed -E 's/&amp;/\&/g'
}
