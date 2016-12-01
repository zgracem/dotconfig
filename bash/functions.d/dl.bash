# download a file
dl()
{
  if _inPath wget; then
    wget "$@"
  elif inPath curl; then
    curl -OJ "$@"
  fi
}

# get HTTP headers
headers()
{
  if _inPath wget; then
    wget --spider -Snv "$@"
  elif inPath curl; then
    curl -Is "$@"
  fi
}
