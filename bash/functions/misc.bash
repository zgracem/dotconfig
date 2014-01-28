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
    _inPath gs || {
        scold "$FUNCNAME" "missing dependency: ghostscript"
        return 1
    }

    for file in "$@"; do
        gs \
            -dSAFER -dBATCH -dNOPAUSE \
            -sDEVICE=pdfwrite \
            -sPDFPassword= \
            -dPDFSETTINGS=/prepress \
            -dPassThroughJPEGImages=true \
            -sOutputFile="${file%.*}_nopassword.pdf" \
            "$file"

        unset file
    done
}
