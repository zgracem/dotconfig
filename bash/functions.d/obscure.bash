_z_obscure()
{
  local instring="${@:-$(</dev/stdin)}"
  local outstring=""

  local i; for (( i = 0; i < ${#instring}; i++ )); do
    local inchar="${instring:$i:1}"
    local outchar="$inchar"

    case ${FUNCNAME[1]} in
      obscure_url)
        printf -v outchar '%%%02x' "'$inchar"
        ;;
      obscure_html)
        printf -v outchar "&#x%02x;" "'$inchar"
        ;;
      *)
        echo >&2 "This function cannot be called directly."
        return 1
        ;;
    esac

    outstring+="$outchar"
  done

  echo "$outstring"
}

obscure_url()   { _z_obscure "$@"; }
obscure_html()  { _z_obscure "$@"; }

obscure_unicode()
{
  <<< "${@:-$(</dev/stdin)}" \
  sed "y/ABCDEHIJKLMNOPSTXYZacdeijlmopsvxy/ΑΒСⅮΕΗΙЈΚⅬΜΝΟΡЅΤΧΥΖасⅾеіјⅼⅿοрѕⅴху/"
}
