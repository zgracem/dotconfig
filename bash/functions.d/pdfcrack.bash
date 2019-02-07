_inPath gs || return

pdfcrack()
{ #: - removes password protection from PDF documents
  #: < GhostScript (http://www.ghostscript.com/)
  local dir_fonts

  case $PLATFORM in
    windows)
      dir_fonts=$(cygpath -au "$WINDIR/Fonts")
      ;;
    mac)
      dir_fonts="/Library/Fonts"
      local threads; threads="-dNumRenderingThreads=${NUMBER_OF_PROCESSORS:-1}"
      ;;
    *)
      scold 'not available on this system'
      return 71
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
      "$threads" \
      "$file"
  done
}
