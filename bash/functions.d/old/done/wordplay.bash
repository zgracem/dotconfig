# ------------------------------------------------------------------------------
# ~zozo/.config/bash/functions/wordplay.bash
# ------------------------------------------------------------------------------

solveword()
{   # crossword solver
    # http://hints.macworld.com/article.php?story=20080224044840101
    declare text
    if [[ $1 ]]; then
        text="$1"
    else
        printf "Pattern (use '.' for unknown letters): "
        read text
    fi

    grep -w "$text" /usr/share/dict/words
}

etym()
{   # get the etymology of a word <3
    declare term url maxwidth=80

    for term in "$@"; do
        url="etymonline.com/index.php?term=$term"

        curl -sS "$url" | grep "<dd " |
        sed -e 's/<a[^>]*>\([^<]*\)<[^>]*>/:\1:/g' -e 's/<[^>]*>//g' |
        fold -sw $(lesserOf $COLUMNS $maxwidth) |
        recode html..utf-8
    done
}
