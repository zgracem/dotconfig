function g2 --description 'Go somewhere'
    argparse l/list h/help -- $argv
    or return

    if set -q _flag_help[1]
        echo "Usage:" (status function) DESTINATION
        echo "`"(status function)" --list` for all DESTINATION values"
        return
    else if set -q _flag_list[1]
        string replace -fr '^\s+case ([^;]+);\s+set dir "?([^"]+)"?' '$1 → $2' <(status filename) | sort
        return
    end

    set -l destination (string split / --max=1 -- $argv[1])

    set -l icloud_docs "$HOME/Library/Mobile Documents/com~apple~CloudDocs"
    set -l steam_dir "$HOME/Library/Application Support/Steam"

    set -l dir
    switch $destination[1]
        case config;    set dir "$XDG_CONFIG_HOME"
        case data;      set dir "$XDG_DATA_HOME"
        case desktop;   set dir "$XDG_DESKTOP_DIR"
        case docs;      set dir "$XDG_DOCUMENTS_DIR"
        case dl;        set dir "$XDG_DOWNLOAD_DIR"
        case icloud;    set dir "$icloud_docs"
        case dev;       set dir "$HOME/Developer"
        case tmp;       set dir "$HOME/var/tmp"
        case local;     set dir "$HOME/.local"
        case private;   set dir "$HOME/.private"
        case defunct;   set dir "$HOME/old"
        case git;       set dir "$HOME/src/github.com"
        case prefs;     set dir "$HOME/Library/Preferences"
        case steam;     set dir "$steam_dir"
        case steamapps; set dir "$steam_dir/steamapps"
        case steamuser; set dir "$steam_dir/userdata"
        case stow;      set dir "$HOME/opt/stow"
        case vs9;       set dir "$HOME/VS/www/vsdotcom"
        case vsbuild;   set dir "$HOME/etc/www/vsdotcom9-build"
        case imprint;   set dir "$HOME/VS/www/vsarts24"
        case finger;    set dir "$HOME/etc/finger"
        case gopher;    set dir "$HOME/etc/gopher"
        case art;       set dir "$icloud_docs/Images/art"
        case acorn;     set dir "$HOME/Art/acorn"
        case qfd;       set dir "$HOME/www/2022/qfd"
        case fonts;     set dir "$HOME/misc/Fonts"
        case music;     set dir "$HOME/Music/Music/Media.localized/Music"
        case twee;      set dir "$HOME/Developer/twee"
        case zpod;      set dir "/Volumes/Hub/Music/zPod"
        case fish;      set dir "$__fish_config_dir"
        case '*'
            echo >&2 "don't know how to go to $destination!"
            return 1
    end
    set destination[1] $dir
    cd (string join / -- $destination)
end
