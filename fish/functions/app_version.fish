function app_version --description 'Get version number from an .app bundle or .exe file' -a app
    if test -x /usr/libexec/PlistBuddy
        set -l info "$app/Contents/Info.plist"

        if test -f $info
            /usr/libexec/PlistBuddy -c 'Print :CFBundleShortVersionString' "$info"
        else
            echo >&2 "not found:" $info
            return 1
        end
    else if in-path wmic
        set -l win_path (cygpath -aw $app | string replace -a '\\' '\\\\')
        wmic datafile where "name=\"$win_path\"" get Version /value \
            | string replace -rf 'Version=([\d.]+)' '$1'
    end
end
