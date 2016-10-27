pdfcrack()
{   # remove password protection from PDF documents
    # Requires: GhostScript (http://www.ghostscript.com/)
    _inPath gs || return

    case $PLATFORM in
        windows)
            local dir_fonts=$(cygpath -au "$WINDIR/Fonts")
            ;;
        mac)
            local dir_fonts="/Library/Fonts"
            local threads="-dNumRenderingThreads=$(sysctl -n hw.availcpu)"
            ;;
        *)
            scold 'not available on this system'
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
