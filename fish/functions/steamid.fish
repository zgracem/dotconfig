function steamid
    if is-macos
        set -f steam_folder "$HOME/Library/Application Support/Steam/SteamApps"
        set -a steam_folder /Volumes/*/Steam/steamapps
    else if is-steamos
        set -f steam_folder $HOME/.local/share/Steam/steamapps
        set -a steam_folder /run/media/deck/*/steamapps
    else
        return 71
    end

    set -f steam_folder (path filter -d $steam_folder)
    if not set -q argv[1]
        for file in $steam_folder/appmanifest_*.acf
            printf "%s\t%s\n" (__steamid_id_from_file $file) (__steamid_name_from_file $file)
        end | sort -nu
        return
    end

    set -f app_manifest (path filter -f $steam_folder/appmanifest_$argv[1].acf)
    if not set -q app_manifest[1]
        echo >&2 "No manifest found for app ID: $argv[1]"
        return 1
    else if set -f app_name (__steamid_name_from_file $app_manifest[1])
        string trim $app_name[1]
        return 0
    else
        echo >&2 "Name not found in manifest: $app_manifest[1]"
        return 1
    end
end

function __steamid_id_from_file
    string match -rg 'appmanifest_(\d+)\.acf' "$argv[1]"
end

function __steamid_name_from_file
    string match -rg '"name"\s+"(.+)"$' <$argv[1] | uniq
end
