in-path strings; or in-path gstrings; or exit

function strings -d "Display printable strings in file(s)"
    # -a = scan the whole file (instead of using insecure libbfd)
    # https://lcamtuf.blogspot.ca/2014/10/psa-dont-run-strings-on-untrusted-files.html
    set -p argv -a
    if in-path strings
        command strings $argv
    else if in-path gstrings
        command gstrings $argv
    else
        return 127
    end
end
