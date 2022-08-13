# `-a` scans the whole file instead of using insecure libbfd
# >> https://lcamtuf.blogspot.ca/2014/10/psa-dont-run-strings-on-untrusted-files.html
if _inPath strings; then
  strings()
  {
    command strings -a "$@"
  }
elif _inPath gstrings; then
  strings()
  {
    gstrings -a "$@"
  }
fi
