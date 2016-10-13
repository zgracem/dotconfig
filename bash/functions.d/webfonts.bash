webfonts()
{
  if [[ -x ~/opt/bin/convertFonts.sh ]]; then
    ~/opt/bin/convertFonts.sh --use-font-weight "$@" *.[ot]tf
  else
    local f; for f in "$@"; do
      sfnt2woff-zopfli "$f" && woff2_compress "$f" && rm -f "$f"
    done
  fi
}
