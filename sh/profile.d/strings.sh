# `-a` scans the whole file instead of using insecure libbfd
# >> https://lcamtuf.blogspot.ca/2014/10/psa-dont-run-strings-on-untrusted-files.html
if command -v strings >/dev/null; then
  strings()
  {
    command strings -a "$@"
  }
elif command -v gstrings >/dev/null; then
  strings()
  {
    gstrings -a "$@"
  }
fi
