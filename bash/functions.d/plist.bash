[[ $OSTYPE =~ darwin ]] || return

plist2bin()  { plutil -convert binary1 -o - "$@"; }

plist2xml()  { plutil -convert    xml1 -o - "$@"; }

plist2json() { plutil -convert json -r -o - "$@"; }

# # destructive versions:
# plist2bin()  { plutil -convert binary1 "$@"; }
# plist2xml()  { plutil -convert    xml1 "$@"; }
# plist2json() { plutil -convert    json "$@"; }
