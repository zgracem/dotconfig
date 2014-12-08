[[ $OSTYPE =~ darwin ]] || return

quarantine()
{
    case $1 in
        disable)
            defaults write com.apple.LaunchServices LSQuarantine -bool NO
            ;;
        enable)
            defaults delete com.apple.LaunchServices LSQuarantine
            ;;
        *)
            scold "Usage: $FUNCNAME [enable|disable]"
            return 1
            ;;
    esac

    echo 'Restart for setting to take effect'
}

unquar()
{
    xattr -d -r com.apple.quarantine "$@"
}
