add_or_set()
{
  local pb=/usr/libexec/PlistBuddy
  $pb -c "Set $1 $3" "$PLIST" 2>/dev/null || $pb -c "Add $1 $2 $3" "$PLIST"
}
export PLIST="$1"
