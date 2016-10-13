# ------------------------------------------------------------------------------
# functions for working with archives in various formats
# ------------------------------------------------------------------------------

roll()
{   # create a new archive

  if (( $# < 2 )); then
    scold "Usage: ${FUNCNAME[0]} archive.ext file [file ...]"
    return 1
  fi

  local archive="$1"; shift

  case $archive in
    *.7z)       7z -mx=9 "$archive" "$@" ;;
    *.jar)      jar cf "$archive" "$@" ;;
    *.rar)      rar -m5 -r "$archive" "$@" ;;
    *.tar)      tar cf "$archive" "$@" ;;
    *.tar.bz2)  tar cjf "$archive" "$@" ;;
    *.tar.gz)   tar czf "$archive" "$@" ;;
    *.tgz)      tar czf "$archive" "$@" ;;
    *.zip)      zip -9r "$archive" "$@" ;;
    *)          scold "${FUNCNAME[0]}: unsupported archive format: ${archive##*.}"
                return 1
                ;;
  esac
}

tarup()
{ # tar + gzip an entire directory
  (( $# == 1 )) || return 1
  local dir="${1%/}"
  roll "${dir}.tar.gz" "${dir%/}/"
}

zipup()
{ # zip an entire directory
  (( $# == 1 )) || return 1
  local dir="${1%/}"
  roll "${dir}.zip" "${dir%/}/"
}

ex()
{ # extract ALL the archives!

  local archive
  local -a archives=("$@")

  for archive in "${archives[@]}"; do
    if [[ -f $archive ]]; then
      case $archive in
        *.tar*|*.zip|*.cpio|*.deb|*.rpm|*.gem|*.7z|*.cab|*.lzh|*.rar|*gz|*bz2|*.lzma|*.xz)
          # list of supported formats from <https://brettcsmith.org/2007/dtrx/>
          dtrx "$archive" ;;
        *.jar)    
          jar xf "$archive" ;;
        *.pkg)    
          pkgutil --expand "$archive" "${archive%.pkg}" ;;
        *.Z)      
          uncompress "$archive" ;;
        Payload)  
          gunzip -dc "$archive" | cpio -i ;;
        *)
          scold "${FUNCNAME[0]}: ${archive}: not a recognized archive"
          return 1 ;;
      esac
    else
      scold "${FUNCNAME[0]}: ${archive}: not found"
      return 1
    fi
  done
}

exls()
{ # list the contents of an archive

  local archive
  local -a archives=("$@")

  for archive in "${archives[@]}"; do
    case $archive in
      *.tar*|*.zip|*.cpio|*.deb|*.rpm|*.gem|*.7z|*.cab|*.lzh|*.rar|*gz|*bz2|*.lzma|*.xz)
        # list of supported formats from <https://brettcsmith.org/2007/dtrx/>
        dtrx --list "$archive" ;;
      *.jar)      
        jar tf "$archive" ;;
      *.pkg)      
        pkgutil --payload-files "$archive" ;;
      *)
        scold "${FUNCNAME[0]}: ${archive}: not a recognized archive"
        return 1 ;;
    esac
  done
}
