lipsum()
( #: - returns lorem ipsum text
  #: $ lipsum [count] [short|medium|long|verylong] [html_options]
  #: | count = number of paragraphs to generate (default: 1)
  #: | short, medium, (very)long = average paragraph length (default: medium)
  #: | HTML options:
  #: |   decorate = add bold, italic, and marked text
  #: |   link = add links
  #: |   ul, ol, dl = add unordered, numbered, and/or description lists
  #: |   bq, code, headers = add blockquotes, code samples, and/or headings
  #: |   all = all of the above

  shopt -s extglob

  local url="http://loripsum.net/api"
  local html=""

  while (( $# )); do
    case $1 in
      -h|--help)
        fxdoc "${FUNCNAME[0]}"
        return
        ;;
      +([[:digit:]]))
        local count=$1
        shift
        ;;
      short|medium|long|verylong)
        local length=$1
        shift
        ;;
      decorate|link|ul|ol|dl|bq|code|headers)
        html+="/$1"
        shift
        ;;
      all)
        html="/decorate/link/ul/ol/dl/bq/code/headers"
        shift
        ;;
      *)
        shift # discard unknown options
        ;;
    esac
  done

  url="${url}/${count-1}/prude/${length-medium}/${html}"

  if [[ -z $html ]]; then
    # strip HTML from output if none was requested
    curl -sS "$url" | sed -E 's#<[^>]*>##g'
  else
    curl -sS "$url"
  fi | cat -s # collapse multiple newlines
)
