# get HTTP headers
headers()
{
  if _inPath wget; then
    wget --spider -Snv "$@"
  elif inPath curl; then
    curl -Is "$@"
  fi
}
