function find-alias -d "Locate the destination of a Finder alias"
    for file in $argv
        set -l path (path resolve $file)
        or return
        osascript 2>/dev/null -e 'tell application "Finder" to return the POSIX path of (the original item of (POSIX file "'$path'" as alias) as alias)'
    end
end
