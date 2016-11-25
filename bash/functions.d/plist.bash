[[ $PLATFORM == mac ]] || return

plist2bin()  { plutil -convert binary1 -o - "$@"; }

plist2xml()  { plutil -convert    xml1 -o - "$@"; }

plist2json() { plutil -convert json -r -o - "$@"; }

# # destructive versions:
# function plist2bin!  { plutil -convert binary1 "$@"; }
# function plist2xml!  { plutil -convert    xml1 "$@"; }
# function plist2json! { plutil -convert    json "$@"; }

readplist()
{
  plutil -p "$1" \
  | less -F
}
