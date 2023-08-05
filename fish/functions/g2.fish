function g2 --description 'Go somewhere' -a alias
    set -l destination (string split / --max=1 -- $alias)

    set -l steam_dir "$HOME/Library/Application Support/Steam"
    set -l dropbox "$HOME/Dropbox"

    set -l dir
    switch $destination[1]
        case config;    set dir "$XDG_CONFIG_HOME"
        case data;      set dir "$XDG_DATA_HOME"
        case desktop;   set dir "$XDG_DESKTOP_DIR"
        case docs;      set dir "$XDG_DOCUMENTS_DIR"
        case dl;        set dir "$XDG_DOWNLOAD_DIR"
        case icloud;    set dir "$HOME/Library/Mobile Documents/com~apple~CloudDocs"
        case dev;       set dir "$HOME/Developer"
        case tmp;       set dir "$HOME/tmp"
        case local;     set dir "$HOME/.local"
        case private;   set dir "$HOME/.private"
        case defunct;   set dir "$HOME/old/src"
        case git;       set dir "$HOME/src/github.com"
        case src;       set dir "$HOME/src/z"
        case prefs;     set dir "$HOME/Library/Preferences"
        case steam;     set dir "$steam_dir"
        case steamapps; set dir "$steam_dir/steamapps"
        case steamuser; set dir "$steam_dir/userdata"
        case stow;      set dir "$HOME/opt/stow"
        case vs9;       set dir "$HOME/VS/www/vsdotcom"
        case imprint;   set dir "$HOME/VS/www/vsbooks"
        case finger;    set dir "$HOME/etc/finger"
        case gopher;    set dir "$HOME/etc/gopher"
        case art;       set dir "$HOME/Art/acorn"
        case fonts;     set dir "$HOME/misc/Fonts"
        case music;     set dir "$HOME/Music/Music/Media.localized/Music"
        case twee;      set dir "$HOME/Documents/Twine/twee"
        case '*'
            echo >&2 "don't know how to go to $destination!"
            return 1
    end
    set destination[1] $dir
    cd (string join / -- $destination)
end
