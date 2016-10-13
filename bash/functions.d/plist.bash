[[ $OSTYPE == darwin* ]] || return

plist2bin()  { plutil -convert binary1 -o - "$@"; }

plist2xml()  { plutil -convert    xml1 -o - "$@"; }

plist2json() { plutil -convert json -r -o - "$@"; }

# # destructive versions:
# plist2bin()  { plutil -convert binary1 "$@"; }
# plist2xml()  { plutil -convert    xml1 "$@"; }
# plist2json() { plutil -convert    json "$@"; }

readplist()
{
  plutil -p "$1" \
  | less -F
}

# readplist() { plutil -convert json -o - "$1" | tr -dc '[\x00-\x1f]' | jq -r .; }
