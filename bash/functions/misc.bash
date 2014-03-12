# ------------------------------------------------------------------------------
# ~zozo/.config/bash/functions/misc.bash
# ------------------------------------------------------------------------------

ssaver()
{   # very serious-looking screensaver of nonsense
    cat /dev/urandom |
    hexdump -C |
    grep --color=auto 'c9 1f'
}

div()
{   # print a bright divider across the terminal
    declare colour line p="${1:-=}"

    printf -v line '%*s' $COLUMNS

    printf "\n${colour_hi}${line// /$p}${colour_reset}\n\n"
}

pdfcrack()
{   # remove password protection from PDF documents
    z_require -a gs || return $?

    declare dir_fonts threads

    case $OSTYPE in
        cygwin)
            dir_fonts="$WINDIR/Fonts" ;;
        darwin*)
            dir_fonts="/Library/Fonts"
            threads="-dNumRenderingThreads=$(sysctl -n hw.availcpu)"
            ;;
        *)
            scold "OS not supported"
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

songinfo()
{   # prints metadata for song files
    declare song="$1"

    case "$song" in
        *.mp3)
            id3v2 -l "$song"
            ;;
        *.m4[ap]|*.mp4|*.aac)
            mp4info "$song"
            ;;
        *)
            scold "$FUNCNAME" "$song: no metadata found"
            return 1
            ;;
    esac
}

md5check()
{   # quickly verify MD5 checksums
    # Usage: md5check CHECKSUM FILE
    
    declare checksum="$1" file="$2"
    declare regex='[[:xdigit:]]{32}'

    [[ $# -eq 2 ]] || {
        scold "Usage: $FUNCNAME CHECKSUM FILE"
        return 1
    }

    [[ $checksum =~ $regex ]] || {
        scold "$FUNCNAME: $checksum: invalid checksum"
        return 65
    }

    [[ -r $file ]] || {
        scold "$FUNCNAME: $file: invalid file"
        return 66
    }

    printf "%s %s" $checksum "$file" | md5sum -c
}
