urlencode()
{ # pure bash URL-encoding
  # >> http://stackoverflow.com/a/10660730

  local instring="${@:-$(</dev/stdin)}"
  local outstring=""

  local i; for (( i = 0; i < ${#instring}; i++ )); do
    local inchar="${instring:$i:1}"
    local outchar="$inchar"

    if [[ $inchar != [-_.~a-zA-Z0-9] ]]; then
      printf -v outchar '%%%02x' "'$inchar"
    fi

    outstring+="$outchar"
  done

  echo "$outstring"
}

urldecode()
{ # corresponding decode function
  # >> http://stackoverflow.com/a/10660730

  local instring="${@:-$(</dev/stdin)}"
  local outstring="${instring//%/\\x}"

  printf "%b\n" "$outstring"
}
