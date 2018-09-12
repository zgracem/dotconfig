safe_email()
{ #: - creates a (relatively) spam-proof email link
  #: $ safe_email user@example.com
  #: = <a href="mailto:user%40example%2ecom">user&#x40;example&#x2e;com</a>
  local instring="${*:-$(</dev/stdin)}"
  local outstring=""
  local outurl=""

  local i; for (( i = 0; i < ${#instring}; i++ )); do
    local inchar="${instring:$i:1}"
    local outchar_url="$inchar"
    local outchar_str="$inchar"

    if [[ $inchar != [a-zA-Z0-9] ]]; then
      # url-encode mailto: address
      printf -v outchar_url '%%%02x' "'$inchar"
      # HTML-entity-ify email address
      printf -v outchar_str "&#x%02x;" "'$inchar"
    fi

    outurl+="$outchar_url"
    outstring+="$outchar_str"
  done

  printf '<a href="mailto:%s">%s</a>\n' "$outurl" "$outstring"
}
