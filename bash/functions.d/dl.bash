# download a file
dl()
{
  if _inPath wget; then
    wget "$@"
  elif inPath curl; then
    curl -OJ "$@"
  fi
}
