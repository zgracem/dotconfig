headers()
{ #: - get HTTP headers
  if _inPath wget; then
    wget --spider -Snv "$@"
  elif _inPath curl; then
    curl -Is "$@"
  fi
}
