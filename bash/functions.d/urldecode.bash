urldecode()
{ # pure bash URL-decoding
  # >> http://stackoverflow.com/a/10660730

  local instring="${@:-$(</dev/stdin)}"
  local outstring="${instring//%/\\x}"

  printf "%b\n" "$outstring"
}
