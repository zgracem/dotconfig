# -----------------------------------------------------------------------------
# ~zozo/.config/bash/osx                          executed if $OSTYPE = darwin*
# say hello: printf "zozo\x40inescapable\x2eorg"
# -----------------------------------------------------------------------------

[[ $OSTYPE =~ darwin ]] || {
    scold "${BASH_SOURCE[0]}" "cannot source on this OS"
    return 1
}

# -----------------------------------------------------------------------------

# hardware identifier
hardware=$(sysctl -n hw.model)

# WiFi card
netcard=$(echo list | scutil | sed -nE 's#^.*Setup:/Network/Interface/(en[[:digit:]])/AirPort$#\1#p')

# AirPort utilities
alias airport='/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport'

# WiFi network
network="$(airport -I | sed -nE 's/^ +SSID: (.*)$/\1/p')"

# compiler flags
export ARCHFLAGS="${ARCHFLAGS:+$ARCHFLAGS }-arch $(sysctl -n hw.machine)"

# -----------------------------------------------------------------------------
# networking &c.
# -----------------------------------------------------------------------------

# number of users connected to AirPort (vars set in private.bash)
alias aeusers="snmpget -v 2c -c $snmp_community -M $snmp_mibPath -m+${snmp_mib} \
    ${snmp_host}.local ${snmp_mib}::wirelessNumber.0 | \
    grep -o --color=never '[[:digit:]+]$'"

# local IP address
alias localip="ipconfig getifaddr ${netcard}"

# IP address of router
alias router="netstat -rn | sed -nE 's/^default +([[:digit:].]+).*$/\1/p'"

# MAC address of WiFi card
alias getmac="ifconfig ${netcard} | sed -nE 's/^[[:space:]]+ether ([[:xdigit:]:]+).*$/\1/p'"

# flush DNS cache
alias flushdns='dscacheutil -flushcache && killall -HUP mDNSResponder 2>/dev/null'

# share $PWD at localhost:7777
alias webshare='python -m SimpleHTTPServer 7777'

# Back to My Mac IPv6 address
bttm=$(echo show Setup:/Network/BackToMyMac | scutil | sed -n 's/.* : *\(.*\).$/\1/p')

# screen sharing
alias ssm='open "vnc://Minerva.$bttm"'
alias sse='open "vnc://Erato.$bttm"'

# -----------------------------------------------------------------------------
# system &c.
# -----------------------------------------------------------------------------

alias lockscreen='"/System/Library/CoreServices/Menu Extras/User.menu/Contents/Resources/CGSession" -suspend'
alias gotosleep='pmset sleepnow'
alias restart='sudo shutdown -r now'
alias screensaver='open "/System/Library/Frameworks/ScreenSaver.framework/Versions/A/Resources/ScreenSaverEngine.app"'

# load Windows on next boot
alias bootwin='sudo bless -mount "/Volumes/BOOTCAMP" -legacy -setBoot -nextonly'
# ...or right now
alias bootcamp='bootwin && restart'

# sound
alias mute='osascript -e "set volume output muted true"'
alias unmute='osascript -e "set volume output muted false"'

# quarantine
alias qudisable='defaults write com.apple.LaunchServices LSQuarantine -bool NO && echo "Restart for setting to take effect"'
alias quenable='defaults delete com.apple.LaunchServices LSQuarantine && echo "Restart for setting to take effect"'
alias unquar='xattr -d -r com.apple.quarantine' # recurses into directories

# Bluetooth mouse battery
alias mousebatt="ioreg -n BNBMouseDevice | sed -nE 's/^.*BatteryPercent\" = ([[:digit:]]+)$/\1/p'"

# -----------------------------------------------------------------------------
# misc. shortcuts
# -----------------------------------------------------------------------------

alias ap='AtomicParsley'
alias ds="$dir_scripts/displaysleep.sh"
alias emptytrash="sudo rm -rf /Volumes/*/.Trashes/*; sudo rm -rf ~/.Trash/*"
alias plist2bin='plutil -convert binary1'
alias plist2xml='plutil -convert xml1'
alias reveal='open -R' # show $1 in Finder
alias subl="/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl"

# change file flags
alias hide='chflags hidden'
alias unhide='chflags nohidden'
alias lockfile='sudo chflags uchg'
alias unlockfile='sudo chflags nouchg'

# copy $PWD to clipboard
alias cppwd='printf $PWD | pbcopy'

# interpret $1 as though it had been typed into the Spotlight menu
alias spliteral='mdfind -interpret'

# http://localhost/cgi-bin/
alias cgibin='cd /Library/WebServer/CGI-Executables/'

# fallbacks
_inPath md5sum  || alias md5sum='md5'
_inPath sha1sum || alias sha1sum='shasum'

# hub -- http://hub.github.com/
_inPath hub || alias git='hub'

# list all apps downloaded from the Mac App Store
alias allstoreapps="find /Applications \
    -path '*Contents/_MASReceipt/receipt' \
    -maxdepth 4 \
    -print | \
    sed 's#.app/Contents/_MASReceipt/receipt#.app#g;s#/Applications/##'"

# list all available iOS IPSW files
# adapted from http://osxdaily.com/2013/11/15/get-list-all-ipsw-files-from-apple/
alias ipsw="curl http://ax.phobos.apple.com.edgesuite.net/WebObjects/MZStore.woa/wa/com.apple.jingle.appserver.client.MZITunesClientCheck/version \
    | sed -nE 's#^[[:space:]]*<string>(http.+ipsw)</string>\$#\1#p' \
    | sort -u"

# -----------------------------------------------------------------------------
# Homebrew
# -----------------------------------------------------------------------------

if _inPath brew; then
    # print developer warnings
    HOMEBREW_DEVELOPER=true

    # keep files in /usr/local/share/info
    HOMEBREW_KEEP_INFO=true

    # don't print beer emoji when logged in remotely
    [[ $SSH_TTY ]] && HOMEBREW_NO_EMOJI=true

    export ${!HOMEBREW_*}

    alias br='brew'
    alias brdoc='brew doctor'
    alias brinfo='brew info'
    alias brin='brew install'
    alias brls='brew list'
    alias brrm='brew uninstall'
    alias brff='brew search'
    alias bruse='brew uses --installed'

    alias brup='brew update && brew upgrade'

    reinstall()
    {
        declare formula

        for formula in "$@"; do
            brew uninstall $formula &&
            brew install $formula
        done
    }

    relink()
    {
        declare formula forceflag

        for formula in "$@"; do
            if [[ $formula == --force ]]; then
                forceflag=true
                shift
                continue
            fi

            brew unlink $formula &&
            brew link ${forceflag+"--force"} $formula

            unset forceflag
        done
    }
fi

# -----------------------------------------------------------------------------
# MacPorts
# -----------------------------------------------------------------------------

# if _inPath port; then
#     alias psearch='port search'
#     alias pinfo='port info'
#     alias pi='sudo port install'
#     alias pui='sudo port uninstall'
#     alias pfiles='port contents'
#     alias portupdate='sudo port selfupdate && sudo port upgrade outdated'
# fi

# -----------------------------------------------------------------------------

return 0
