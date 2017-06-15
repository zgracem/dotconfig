dl()
{ #: - download a file to the current directory
  #: $ dl <url>
  if _inPath wget; then
    wget "$@"
  elif _inPath curl; then
    curl -OJ "$@"
  fi
}
