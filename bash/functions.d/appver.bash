[[ $OSTYPE =~ darwin ]] || return

appver()
{
    local app=$1
    local info="$app/Contents/Info.plist"

    if [[ -f $info ]]; then
        /usr/libexec/PlistBuddy -c 'Print :CFBundleShortVersionString' "$info"
    else
        scold "not found: $info"
        return 1
    fi
}
