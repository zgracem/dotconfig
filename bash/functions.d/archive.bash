# ------------------------------------------------------------------------------
# functions for working with archives in various formats
# ------------------------------------------------------------------------------

roll()
{   # create a new archive

    if (( $# < 2 )); then
        scold "Usage: ${FUNCNAME[0]} ARCHIVE.EXT FILE [FILE ...]"
        return $EX_USAGE
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
                    return $EX_USAGE
                    ;;
    esac
}

tarup()
{   # tar + gzip an entire directory

    (( $# == 1 )) || return $EX_USAGE
    local dir="${1%/}"
    roll "${dir}.tar.gz" "${dir%/}/"
}

zipup()
{   # zip an entire directory

    (( $# == 1 )) || return $EX_USAGE
    local dir="${1%/}"
    roll "${dir}.zip" "${dir%/}/"
}

ex()
{   # extract ALL the archives!
    # [source unknown, adapted/modified by me]

    local archive
    local -a archives=("$@")

    for archive in "${archives[@]}"; do
        if [[ -f $archive ]]; then
            case $archive in
                *.tar.bz2)  tar xjf "$archive" ;;
                *.tar.gz)   tar xzf "$archive" ;;
                *.tar.xz)   unxz -ck "$archive" | tar xf - ;;
                *.7z)       7z x "$archive"    ;;
                *.bz2)      bunzip2 "$archive" ;;
                *.gz)       gunzip "$archive"  ;;
                *.jar)      jar xf "$archive"  ;;
                *.pkg)      pkgutil --expand "$archive" "${archive%.pkg}" ;;
                *.rar)      unrar x "$archive" ;;
                *.tar)      tar xf "$archive"  ;;
                *.tbz2)     tar xjf "$archive" ;;
                *.tgz)      tar xzf "$archive" ;;
                *.xz)       unxz -k "$archive" ;;
                *.Z)        uncompress "$archive" ;;
                *.zip)      unzip "$archive"   ;;
                Payload)    gunzip -dc "$archive" \
                            cpio -i ;;
                *)          scold "${FUNCNAME[0]}: ${archive}: not a recognized archive"
                            return 1 ;;
            esac
        else
            scold "${FUNCNAME[0]}: ${archive}: not found"
            return 1
        fi
    done
}

exls()
{   # list the contents of an archive

    local archive
    local -a archives=("$@")

    for archive in "${archives[@]}"; do
        case $archive in
            *.tar*)     tar tf "$archive"  ;;
            *.7z)       7z l "$archive"    ;;
            *.jar)      jar tf "$archive"  ;;
            *.pkg)      pkgutil --payload-files "$archive" ;;
            *.rar)      unrar vb "$archive"; echo ;;
            *.tbz2)     tar tf "$archive"  ;;
            *.tgz)      tar tf "$archive"  ;;
            *.zip)      zip -sf "$archive" ;;
            *)          scold "${FUNCNAME[0]}: ${archive}: not a recognized archive"
                        return 1 ;;
        esac
    done
}
