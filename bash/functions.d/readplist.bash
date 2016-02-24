_inPath plutil && readplist() { plutil -p "$1" | less -F; }

# readplist() { plutil -convert json -o - "$1" | tr -dc '[\x00-\x1f]' | jq -r .; }
