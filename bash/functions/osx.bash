# ------------------------------------------------------------------------------
# ~zozo/.config/bash/functions/osx.bash
# ------------------------------------------------------------------------------

[[ $OSTYPE =~ darwin ]] || return 1

# ------------------------------------------------------------------------------

f()
{   # open a Finder window for the current/specified directory
    declare here=${1-.}
    open -a Finder "$here"
}

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

ql()
{   # launch a QuickLook preview of a file
    quietly /usr/bin/qlmanage -p "$1"
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

console()
{   # scan system messages from Terminal
    # http://brettterpstra.com/a-simple-but-handy-bash-function-console/
    if [[ $# > 0 ]]; then
        query=$(echo "$*"|tr -s ' ' '|')
        tail -f /var/log/system.log | grep -i --color=auto -E "$query"
    else
        tail -f /var/log/system.log
    fi
}

remind()
{   # add reminder to Reminders.app (OS X 10.8)
    # Usage: `remind 'foo'` or `echo 'foo' | remind`
    # Based on: https://github.com/mathiasbynens/dotfiles/blob/master/.functions

    declare text
    [[ -t 0 ]] && {
        text="$1"
    } || {
        text="$(cat)" # standard input
    }

    osascript >/dev/null <<EOF
    tell application "Reminders"
        tell the default list
            make new reminder with properties {name:"$text"}
        end tell
    end tell
EOF
}

scan()
{

    declare usage="$FUNCNAME ssh | wifi | file NAME"
    case $1 in
        ssh) # list all SSH-enabled hosts on the domain
            /usr/bin/dns-sd -B _ssh._tcp
            ;;
        [Ww]i[Ff]i) # scan for WiFi networks
            /System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -s
            ;;
        file)
            sudo opensnoop -f "$2"
            ;;
        *)
            scold "Usage: %s" "$usage"
            return 1
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

quit()
{   # "gently" quit an application
    
    [[ $# -ge 1 ]] || return 64

    local -a apps=("$@")
    local app

    for app in "${apps[@]}"; do
        osascript -e "quit app '${cmd}'"
    done
}
