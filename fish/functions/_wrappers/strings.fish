# `-a` scans the whole file instead of using insecure libbfd
# >> https://lcamtuf.blogspot.ca/2014/10/psa-dont-run-strings-on-untrusted-files.html
if command -sq strings
    function strings
        set -p argv -a
        command strings $argv
    end
else if command -sq gstrings
    function strings
        set -p argv -a
        command gstrings $argv
    end
end
