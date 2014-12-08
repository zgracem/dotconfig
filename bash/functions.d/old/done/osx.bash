# ------------------------------------------------------------------------------
# ~zozo/.config/bash/functions/osx.bash
# ------------------------------------------------------------------------------

[[ $OSTYPE =~ darwin ]] || return 1

# ------------------------------------------------------------------------------

cdf()
{   # cd to frontmost window of Finder
    # http://hayne.net/MacDev/Bash/aliases.bash
    declare currFolderPath=$(/usr/bin/osascript <<"    EOT"
        tell application "Finder"
            try
                set currFolder to (folder of the front window as alias)
            on error
                set currFolder to (path to desktop folder as alias)
            end try
            POSIX path of currFolder
        end tell
    EOT
    )
    cd "$currFolderPath"
}


abspath()
{   # return the absolute path to a file because Darwin's readlink(1) is broken
    # http://stackoverflow.com/a/3915986
    case "$1" in    #
        /*) printf "%s\n" "$1"
        ;;
        *)  printf "%s\n" "$PWD/$1"
        ;;
    esac
}

bluetooth()
{   # toggle Bluetooth (http://frederikseiffert.de/blueutil)

    _inPath blueutil || return 1

    declare status="$(blueutil status)"

    case $status in
        *off)   blueutil on  ;;
        *on)    blueutil off ;;
        *)      return 1 ;;
    esac
}

wifi()
{   # toggle WiFi power
    declare status="$(networksetup -getairportpower $netcard 2>/dev/null)"

    case $status in
        *Off)   networksetup -setairportpower $netcard on  ;;
        *On)    networksetup -setairportpower $netcard off ;;
        *)      return 1 ;;
    esac
}


whereami()
{   # echo the street address of your current location
    # Based on: https://gist.github.com/ttscoff/76e5d7efb60d7ac04350
    # Requires: jq (http://stedolan.github.io/jq/)
    #           get-location (https://github.com/lindes/get-location)

    declare latlong address

    latlong=$($HOME/bin/get-location 2>/dev/null \
        | sed -nE 's/.*<(.*)>.*/\1/p')

    address=$(curl -s "http://maps.googleapis.com/maps/api/geocode/json?latlng=${latlong}&sensor=false" \
          | jq -r .results[0].formatted_address)

    if [[ -n $address ]]; then
        echo "$address"
    fi
}
