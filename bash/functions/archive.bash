# ------------------------------------------------------------------------------
# ~zozo/.config/bash/functions/archives.bash
# ------------------------------------------------------------------------------

roll()
{   # create a new archive
    # [source unknown, adapted/modified by me]

    if [[ $# -lt 2 ]]; then
        printf "Usage: %s archive.ext file1 ...\n" $FUNCNAME 1>&2
        return 1
    fi

    declare archive="$1"; shift

    case $archive in
        *.7z)       7z -mx=9 $archive "$@";;
        *.jar)      jar cf $archive "$@" ;;
        *.rar)      rar -m5 -r $archive "$@" ;;
        *.tar)      tar cf $archive "$@"  ;;
        *.tar.bz2)  tar cjf $archive "$@" ;;
        *.tar.gz)   tar czf $archive "$@" ;;
        *.tgz)      tar czf $archive "$@" ;;
        *.zip)      zip -9r $archive "$@" ;;
        *)          printf "%s: Can't make a .%s archive\n" $FUNCNAME ${archive##*.} 1>&2
                    return 1 ;;
    esac
}

tarup()
{   # tar+gzip an entire folder
    declare dir="${1%/}"
    roll "${dir}.tar.gz" "${dir%/}/";
}

zipup()
{   # zip an entire folder
    declare dir="${1%/}"
    roll "${dir}.zip" "${dir%/}/";
}

ex()
{   # extract ALL the archives!
    # [source unknown, adapted/modified by me]
    declare archive
    for archive in "$@"; do
        if [[ -f $archive ]]; then
            case "$archive" in
                *.tar.bz2)  tar xjf "$archive" ;;
                *.tar.gz)   tar xzf "$archive" ;;
                *.tar.xz)   unxz -ck "$archive" | tar xf - ;;
                *.7z)       7z x "$archive"    ;;
                *.bz2)      bunzip2 "$archive" ;;
                *.gz)       gunzip "$archive"  ;;
                *.jar)      jar xf "$archive"  ;;
                *.pkg)      pkgutil --expand "$archive" . ;;
                *.rar)      unrar x "$archive" ;;
                *.tar)      tar xf "$archive"  ;;
                *.tbz2)     tar xjf "$archive" ;;
                *.tgz)      tar xzf "$archive" ;;
                *.xz)       unxz -k "$archive" ;;
                *.Z)        uncompress "$archive" ;;
                *.zip)      unzip "$archive"   ;;
                *)          printf "%s: '%s' is not a recognized archive\n" $FUNCNAME "$archive" 1>&2
                            return 1 ;;
            esac
        else
            printf "%s: '%s' does not exist\n" $FUNCNAME "$archive" 1>&2
            return 1
        fi
    done
}

exls()
{   # list the contents of an archive
    declare archive
    for archive in "$@"; do
        case "$archive" in
            *.tar*)     tar tf "$archive"  ;;
            *.7z)       7z l "$archive"    ;;
            *.jar)      jar tf "$archive"  ;;
            *.pkg)      pkgutil --payload-files "$archive" ;;
            *.rar)      unrar vb "$archive"; echo ;;
            *.tbz2)     tar tf "$archive"  ;;
            *.tgz)      tar tf "$archive"  ;;
            *.zip)      zip -sf "$archive" ;;
            *)          printf "%s: '%s' is not a recognized archive\n" $FUNCNAME "$archive" 1>&2
                        return 1 ;;
        esac
    done
}
