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
    /usr/bin/qlmanage -p "$1" &>/dev/null
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

brewup()
{   # update and upgrade installed Homebrew packages
    
    _inPath brew || return 1

    brew update && pause
    brew upgrade
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
