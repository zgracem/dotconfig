# `-a` scans the whole file instead of using insecure libbfd
# >> https://lcamtuf.blogspot.ca/2014/10/psa-dont-run-strings-on-untrusted-files.html
if in-path strings
  function strings; command strings -a $argv; end
else if in-path gstrings
  function strings; gstrings -a $argv; end
end
