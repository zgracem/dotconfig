function steamid
    argparse l/list s/search h/help -- $argv
    or return
    set -f usage "steamid [-l|--list] [-s|--search] [id ...]"

    __steamid_find_folders
    or return

    if set -q _flag_list[1]
        __steamid_list_all $steam_folders
        return
    else if set -q _flag_search[1]
        __steamid_list_all $steam_folders | grep --color=auto $argv[1]
        return
    else if set -q _flag_help[1]
        echo "Usage: $usage"
        return
    else if not set -q argv[1]
        echo "Usage: $usage"
        return 2
    end

    set -f app_manifest (path filter -f $steam_folders/appmanifest_$argv[1].acf)
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

function __steamid_list_all
    set -f manifests $argv/appmanifest_*.acf
    if not set -q manifests[1]
        echo >&2 "No manifests found: $argv"
        return 1
    end
    for file in $manifests
        set -l id (__steamid_id_from_file $file)
        set -l name (__steamid_name_from_file $file)
        printf "%d\t%s\n" $id $name
    end | sort -nu
end

function __steamid_find_folders
    set -q -g steam_folders[1]; and return 0
    if is-macos
        set -gx steam_folders "$HOME/Library/Application Support/Steam/SteamApps"
        set -a steam_folders /Volumes/*/Steam/steamapps
    else if is-steamos
        set -gx steam_folders $HOME/.local/share/Steam/steamapps
        set -a steam_folders /run/media/deck/*/steamapps
    else
        return 71
    end
    set -gx steam_folders (path filter -d $steam_folders)
end

function __steamid_id_from_file
    string match -rg 'appmanifest_(\d+)\.acf' $argv
end

function __steamid_name_from_file
    string match -rg '"name"\s+"(.+)"$' <$argv[1] | uniq
end
