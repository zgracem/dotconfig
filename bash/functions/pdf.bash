# ------------------------------------------------------------------------------
# ~zozo/.config/bash/functions/misc.bash
# ------------------------------------------------------------------------------

pdfcrack()
{   # remove password protection from PDF documents
    _inPath gs || {
        scold "$FUNCNAME: Ghostscript not found"
        return 1
    }

    declare dir_fonts threads

    case $OSTYPE in
        cygwin)
            dir_fonts="$WINDIR/Fonts" ;;
        darwin*)
            dir_fonts="/Library/Fonts"
            threads="-dNumRenderingThreads=$(sysctl -n hw.availcpu)"
            ;;
        *)
            scold "OS not supported"
            return 1
            ;;
    esac

    for file in "$@"; do
        gs \
            -dSAFER -dBATCH -dNOPAUSE \
            -sDEVICE=pdfwrite \
            -sPDFPassword= \
            -sFONTPATH="$dir_fonts" \
            -dPDFSETTINGS=/prepress \
            -dPassThroughJPEGImages=true \
            -sOutputFile="${file%.*}_nopassword.pdf" \
            ${threads} \
            "$file"
    done
}

pdfmarks()
{   # dump the titles of all bookmarks in a PDF
    # Usage: pdfmarks file.pdf

    _inPath pdftk || return 64

    local pdf="$1"

    pdftk "$pdf" dump_data output - \
    | sed -nE -e 's/^BookmarkTitle: (.+)$/\1/p' \
    | sed -E 's/&amp;/\&/g'
}
