sublsync()
{
    local src dst

    case $HOSTNAME in
        *.atco.com)
            src="$dir_apps/Sublime Text 3/Data/Packages/User"
            dst="Athena:/Users/zozo/Dropbox/Apps/Sublime Text 3"
            ;;
        # Athena*|Erato*)
        #     src="$HOME/Dropbox/Apps/Sublime Text 3"
        #     dst="$HOME/Dropbox/Apps/Sublime Text 3"
        #     ;;
        *)
            return 1
            ;;
    esac

    syncdir "$src" "$dst" --exclude='Package Control*'
}
