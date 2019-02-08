_inPath gs || return

pdfcrack()
{ #: - removes password protection from PDF documents
  #: < GhostScript (http://www.ghostscript.com/)
  local dir_fonts
  local file="$1"
  local password="$2"

  case $PLATFORM in
    windows)
      dir_fonts=$(cygpath -au "$WINDIR/Fonts")
      ;;
    mac)
      dir_fonts="/Library/Fonts"
      ;;
    *)
      scold 'not available on this system'
      return 71
      ;;
  esac

  gs \
    -dSAFER -dBATCH -dNOPAUSE \
    -sDEVICE=pdfwrite \
    -sPDFPassword="$password" \
    -sFONTPATH="$dir_fonts" \
    -dPDFSETTINGS=/prepress \
    -dPassThroughJPEGImages=true \
    -sOutputFile="${file%.*}_nopassword.pdf" \
    "$file"
}
