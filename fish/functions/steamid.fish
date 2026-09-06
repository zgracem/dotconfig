function steamid
    argparse d/dirs l/list s/search h/help -- $argv
    or return

    set -f usage "steamid [-d|--dirs] [-l|--list] [-s|--search NAME] [ID ...]"

    if is-macos
        set -f steam_folders "$HOME/Library/Application Support/Steam/SteamApps"
        set -a steam_folders /Volumes/*/Steam/steamapps
    else if is-steamos
        set -f steam_folders $HOME/.local/share/Steam/steamapps
        set -a steam_folders /run/media/deck/*/steamapps
    else
        return 71
    end
    set -f steam_folders (path filter -d $steam_folders)

    if set -q _flag_dirs[1]
        echo -ns $steam_folders\n
        return
    else if set -q _flag_list[1]
        __steamid_list_all $steam_folders
        return
    else if set -q _flag_search[1]
        __steamid_list_all $steam_folders | grep --color=auto $argv[1]
        return
    else if set -q _flag_help[1]
        echo "Usage: $usage"
        return
    else if not set -q argv[1]
        echo >&2 "Usage: $usage"
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

function __steamid_list_all -d 'List all game IDs and their titles'
    set -f manifests $argv/appmanifest_*.acf
    if not set -q manifests[1]
        echo >&2 "No manifests found in any folder: $argv"
        return 1
    end
    echo -s (set_color -u) "ID" (set_color normal) \t (set_color -u) "Name" (set_color normal)
    for file in $manifests
        printf "%d\t%s\n" (__steamid_id_from_file $file) (__steamid_name_from_file $file)
    end | sort -nu
end

function __steamid_id_from_file -d 'Extract ID from manifest filename'
    string match -rg 'appmanifest_(\d+)\.acf' $argv
end

function __steamid_name_from_file -d 'Extract name from manifest file contents'
    string match -rg '"name"\s+"(.+)"$' <$argv[1] | uniq
end
