lipsum()
{   # return a paragraph of lorem ipsum text
    local regex_help='-?-h(elp)?'

    [[ $1 =~ $regex_help ]] && {
        printf "Usage: %s [COUNT] [short|medium|long|verylong]\n" "$FUNCNAME"
        return
    }

    local count="${1:-1}"
    local length="${2:-medium}"

    curl -sS "http://loripsum.net/api/${count}/prude/${length}" \
    | sed -e 's#<[^>]*>##g'

    # API parameters:
    #   (integer) - The number of paragraphs to generate.
    #   short, medium, long, verylong - The average length of a paragraph.
    #   decorate - Add bold, italic and marked text.
    #   link - Add links.
    #   ul/ol/dl - Add unordered/numbered/description lists.
    #   bq/code/headers - Add blockquotes/code samples/headers.
}
