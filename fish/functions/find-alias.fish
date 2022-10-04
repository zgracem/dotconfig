is-macos; or exit

function find-alias -d "Locate the destination of a Finder alias"
    osascript 2>/dev/null \
        -e 'tell application "Finder"' \
        -e     'set theAlias to the POSIX file "'$argv[1]'" as alias' \
        -e     'set theFile to the original item of theAlias as alias' \
        -e     'return the POSIX path of theFile' \
        -e 'end tell'
end
