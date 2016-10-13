# Requires pdftk (https://www.pdflabs.com/tools/pdftk-the-pdf-toolkit/)
_inPath pdftk || return

pdfmarks()
{ # dump the titles of all bookmarks in a PDF
  # Usage: pdfmarks file.pdf
  pdftk "$1" dump_data output - \
  | sed -nE 's/^BookmarkTitle: (.+)$/\1/p' \
  | sed -E 's/&amp;/\&/g'
}
