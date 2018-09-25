[[ $PLATFORM == mac ]] || return

app_version()
{ #: - returns the version number of a macOS application
  #: $ app_version <Example.app>
  local app="$1"
  local info="$app/Contents/Info.plist"

  if [[ -f $info ]]; then
    /usr/libexec/PlistBuddy -c 'Print :CFBundleShortVersionString' "$info"
  else
    scold "not found: $info"
    return 1
  fi
}
