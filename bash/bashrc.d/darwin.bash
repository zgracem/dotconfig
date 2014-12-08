# -----------------------------------------------------------------------------
# darwin
# -----------------------------------------------------------------------------

if ! [[ $OSTYPE =~ darwin ]]; then
    return
fi

# -----------------------------------------------------------------------------

# # hardware identifier
# hardware=$(sysctl -n hw.model)

# # Back to My Mac IPv6 address
# if [[ -z $bttm ]]; then
#     bttm=$(echo show Setup:/Network/BackToMyMac \
#         | scutil \
#         | sed -n 's/.* : *\(.*\).$/\1/p')
# fi

# -----------------------------------------------------------------------------
# system commands
# -----------------------------------------------------------------------------

alias lockscreen='"/System/Library/CoreServices/Menu Extras/User.menu/Contents/Resources/CGSession" -suspend'
alias gotosleep='pmset sleepnow'
alias restart='sudo shutdown -r now'
alias screensaver='open "/System/Library/Frameworks/ScreenSaver.framework/Versions/A/Resources/ScreenSaverEngine.app"'

# sound
alias mute='osascript -e "set volume output muted true"'
alias unmute='osascript -e "set volume output muted false"'

# load Windows on next boot
alias bootwin='sudo bless -mount "/Volumes/BOOTCAMP" -legacy -setBoot -nextonly '
# ...or right now
alias bootcamp='bootwin && restart'

mousebatt()
{   # print status of Bluetooth mouse battery
    ioreg -d 7 -n BNBMouseDevice \
    | sed -nE 's/^.*\"BatteryPercent\" = ([[:digit:]]+)$/\1%/p'
}
