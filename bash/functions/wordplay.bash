# ------------------------------------------------------------------------------
# ~zozo/.config/bash/functions/wordplay.bash
# ------------------------------------------------------------------------------

lipsum()
{   # return a paragraph of lorem ipsum text
    declare count="${1:-1}"
    declare length="${2:-medium}"

    curl -sS "http://loripsum.net/api/${count}/prude/${length}" |
    sed -e 's#<[^>]*>##g'

    # API parameters:
    # (integer) - The number of paragraphs to generate.
    # short, medium, long, verylong - The average length of a paragraph.
    # decorate - Add bold, italic and marked text.
    # link - Add links.
    # ul/ol/dl - Add unordered/numbered/description lists.
    # bq/code/headers - Add blockquotes/code samples/headers.
}

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
