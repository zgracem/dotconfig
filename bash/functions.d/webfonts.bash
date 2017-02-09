webfonts()
{ #: - converts TrueType and OpenType fonts for CSS @font-face use
  #: $ webfonts [<files>]
  #: | files = font files to convert (default: *.ttf and *.otf in PWD)
  if [[ -z $@ ]]; then
    set -- "$PWD"/*.[ot]tf
  fi

  if [[ -x ~/opt/bin/convertFonts.sh ]]; then
    ~/opt/bin/convertFonts.sh --use-font-weight "$@"
  else
    local f; for f in "$@"; do
      sfnt2woff-zopfli "$f" && woff2_compress "$f" && rm -f "$f"
    done
  fi
}
