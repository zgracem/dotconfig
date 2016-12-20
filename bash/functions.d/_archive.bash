# ------------------------------------------------------------------------------
# functions for working with archives in various formats
# ------------------------------------------------------------------------------

roll()
{ # create a new archive

  if (( $# < 2 )); then
    scold "Usage: $FUNCNAME archive.ext file [file ...]"
    return 64
  fi

  local archive="$1"; shift

  case $archive in
    *.tar.bz2)  tar cjf "$archive" "$@" ;;
    *.tar.gz)   tar czf "$archive" "$@" ;;
    *.tar.xz)   tar cf - "$@" | xz -6e > "$archive" ;;
    *.7z)       7z a -mx=9 "$archive" "$@" ;;
    *.jar)      jar cf "$archive" "$@" ;;
    *.rar)      rar -m5 -r "$archive" "$@" ;;
    *.tar)      tar cf "$archive" "$@" ;;
    *.tgz)      tar czf "$archive" "$@" ;;
    *.zip)      zip -9r "$archive" "$@" ;;
    *)          scold "$FUNCNAME: unsupported archive format: .${archive#*.}"
                return 1 ;;
  esac
}

tarup()
{ # tar + gzip an entire directory
  (( $# == 1 )) || return 64
  local dir="${1%/}"
  roll "$dir.tar.gz" "$dir/"
}

zipup()
{ # zip an entire directory
  (( $# == 1 )) || return 64
  local dir="${1%/}"
  roll "$dir.zip" "$dir/"
}

ex()
{ # extract ALL the archives!

  local archive
  local -a archives=("$@")

  for archive in "${archives[@]}"; do
    case $archive in
      *.tar.bz2)  tar xjf "$archive" ;;
      *.bz2)      bunzip2 "$archive" ;;
      *.tar.gz)   tar xzf "$archive" ;;
      *.gz)       gunzip "$archive" ;;
      *.tar.xz)   unxz -ck "$archive" | tar xf - ;;
      *.xz)       unxz -k "$archive" ;;
      *.7z)       7z x "$archive" ;;
      *.jar)      jar xf "$archive" ;;
      *.pkg)      pkgutil --expand "$archive" "${archive%.pkg}" ;;
      *.rar)      unrar x "$archive" ;;
      *.tar)      tar xf "$archive"  ;;
      *.tbz2)     tar xjf "$archive" ;;
      *.tgz)      tar xzf "$archive" ;;
      *.Z)        uncompress "$archive" ;;
      *.zip)      unzip "$archive" ;;
      Payload)    cpio -imv -F "$archive" ;;
      *)          scold "$FUNCNAME: $archive: not a recognized archive"
                  return 1 ;;
    esac
  done
}

exls()
{ # list the contents of an archive

  local archive
  local -a archives=("$@")

  for archive in "${archives[@]}"; do
    case $archive in
      *.7z)     7z l "$archive" ;;
      *.jar)    jar tf "$archive" ;;
      *.pkg)    pkgutil --payload-files "$archive" ;;
      *.rar)    unrar vb "$archive"; echo ;;
      *.tar*)   tar tf "$archive" ;;
      *.tbz2)   tar tf "$archive"  ;;
      *.tgz)    tar tf "$archive"  ;;
      *.zip)    zip -sf "$archive" ;;
      Payload)  cpio -itv -F "$archive" ;;
      *)        scold "$FUNCNAME: $archive: not a recognized archive"
                return 1 ;;
    esac
  done
}
