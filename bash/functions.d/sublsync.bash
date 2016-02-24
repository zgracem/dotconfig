sublsync()
{
    local src dst

    case $HOSTNAME in
        WS144966*)
            src="$dir_apps/Sublime Text 3/Data/Packages/User"
            dst='Minerva:/Users/zozo/Dropbox/Apps/Sublime Text 3'
            ;;
        # Minerva|Erato)
        #     src="$HOME/Dropbox/Apps/Sublime Text 3"
        #     dst="$HOME/Dropbox/Apps/Sublime Text 3"
        #     ;;
        *)
            return 1
            ;;
    esac

    syncdir "$src" "$dst" --exclude='Package Control*'
}
