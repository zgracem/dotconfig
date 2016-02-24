_inPath osascript || return

nicequit()
{
    osascript - <<< "tell application \"$1\" to quit"
}
