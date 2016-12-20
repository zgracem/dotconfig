obscure()
{
  local usage="$FUNCNAME --url|--html|--unicode \"text\""
  local mode="$1"; shift

  if [[ $mode == --unicode ]]; then
    <<< "${@:-$(</dev/stdin)}" \
    sed "y/ABCDEHIJKLMNOPSTXYZacdeijlmopsvxy/ΑΒСⅮΕΗΙЈΚⅬΜΝΟΡЅΤΧΥΖасⅾеіјⅼⅿοрѕⅴху/"
    return
  fi

  local instring="${@:-$(</dev/stdin)}"
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
        printf >&2 "Usage: %s\n" "$usage"
        return 64
        ;;
    esac

    outstring+="$outchar"
  done

  echo "$outstring"
}
