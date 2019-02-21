# ------------------------------------------------------------------------------
# functions for working with archives in various formats
# ------------------------------------------------------------------------------

roll()
{ #: - create a new archive
  #: $ roll <archive>.<ext> <file> [<file2> ...]

  if (( $# < 2 )); then
    fx_usage >&2
    return 1
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
    *)          scold "${FUNCNAME[0]}: unsupported archive format: .${archive#*.}"
                return 1 ;;
  esac
}

tarup()
{ #: - archives an entire directory as a .tar.gz
  #: $ tarup <directory>
  (( $# == 1 )) || return 1
  local dir="${1%/}"
  roll "$dir.tar.gz" "$dir/"
}

zipup()
{ #: - archives an entire directory as a .zip
  #: $ zipup <directory>
  (( $# == 1 )) || return 1
  local dir="${1%/}"
  roll "$dir.zip" "$dir/"
}

ex()
{ #: - extract ALL the archives!
  #: $ ex <archive> [<archive2> ...]

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
      *)          scold "${FUNCNAME[0]}: $archive: not a recognized archive"
                  return 1 ;;
    esac
  done
}

exls()
{ # list the contents of an archive
  #: $ exls <archive>

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
      *)        scold "${FUNCNAME[0]}: $archive: not a recognized archive"
                return 1 ;;
    esac
  done
}
