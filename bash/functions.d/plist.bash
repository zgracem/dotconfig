_inPath plutil || return

plist2bin()
{
    plutil -convert binary1 "$@"
}

plist2xml()
{
    plutil -convert xml1 "$@"
}
