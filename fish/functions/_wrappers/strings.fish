# `-a` scans the whole file instead of using insecure libbfd
# >> https://lcamtuf.blogspot.ca/2014/10/psa-dont-run-strings-on-untrusted-files.html
if in-path strings
    function strings
        set -p argv -a
        command strings $argv
    end
else if in-path gstrings
    function strings
        set -p argv -a
        command gstrings $argv
    end
end
