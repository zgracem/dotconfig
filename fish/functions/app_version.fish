function app_version --description 'Get version number from an .app bundle or .exe file' -a app
    if is-macos
        set -l info "$app/Contents/Info.plist"
        if test -f $info
            pyjamas -o json $info | jq -r .CFBundleShortVersionString
        else
            echo >&2 "not found:" $info
            return 1
        end
    else if is-cygwin
        set -l win_path (cygpath -aw $app | string replace -a '\\' '\\\\')
        wmic datafile where "name=\"$win_path\"" get Version /value \
            | string replace -rf 'Version=([\d.]+)' '$1'
    end
end
