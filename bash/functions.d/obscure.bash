obscure()
{ #: - obscures a string of text
  #: $ obscure --url|--html|--unicode <text>
  #: | --url     = URL-encode TEXT
  #: | --html    = convert TEXT to HTML entities
  #: | --unicode = replace Latin characters in TEXT with Unicode look-alikes
  local usage="${FUNCNAME[0]} --url|--html|--unicode \"text\""
  local mode="$1"; shift

  if [[ $mode == --unicode ]]; then
    <<< "${*:-$(</dev/stdin)}" \
    sed "y/ABCDEHIJKLMNOPSTXYZacdeijlmopsvxy/ΑΒСⅮΕΗΙЈΚⅬΜΝΟΡЅΤΧΥΖасⅾеіјⅼⅿοрѕⅴху/"
    return
  fi

  local instring="${*:-$(</dev/stdin)}"
  local outstring=""

  local i; for (( i = 0; i < ${#instring}; i++ )); do
    local inchar="${instring:$i:1}"
    local outchar="$inchar"

    case $mode in
      --url)
        printf -v outchar '%%%02x' "'$inchar"
        ;;
      --html)
        printf -v outchar "&#x%02x;" "'$inchar"
        ;;
      *)
        fx_usage >&2
        return 64
        ;;
    esac

    outstring+="$outchar"
  done

  echo "$outstring"
}
