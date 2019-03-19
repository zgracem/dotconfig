function app_version -a app --description 'Get the version number from an .app bundle'
  set -l info "$app/Contents/Info.plist"

  if [ -f $info ]
    /usr/libexec/PlistBuddy -c 'Print :CFBundleShortVersionString' "$info"
  else
    echo >&2 "not found:" $info
    return 1
  end
end
