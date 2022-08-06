function g2 --description 'Go somewhere' -a alias
    set -l destination (string split / --max=1 -- $alias)

    set -l steam_dir "$HOME/Library/Application Support/Steam"
    set -l dropbox "$HOME/Dropbox"

    set -l dir
    switch $destination[1]
        case desktop
            set dir "$XDG_DESKTOP_DIR"
        case dl
            set dir "$XDG_DOWNLOAD_DIR"
        case local
            set dir "$HOME/.local"
        case hub
            set dir "$HOME/.local/src/github.com"
        case scratch
            set dir "$HOME/tmp/_scratch"
        case defunct
            set dir "$HOME/old/src"
        case git
            set dir "$HOME/GitHub"
        case proj
            set dir "$HOME/Projects"
        case ruby
            set dir "$dropbox/dev/ruby"
        case scripts
            set dir "$dropbox/dev/shell"
        case sdmods
            set dir "$steam_dir/steamapps/common/Stardew Valley/Contents/MacOS/Mods"
        case sdsaves
            set dir "$XDG_CONFIG_DIR/StardewValley/Saves"
        case steam
            set dir "$steam_dir"
        case steamapps
            set dir "$steam_dir/steamapps"
        case steamuser
            set dir "$steam_dir/userdata"
        case stow
            set dir "$HOME/opt/stow"
        case vs9
            set dir "$HOME/VS/www/vsdotcom"
        case 2a
            set dir "$HOME/VS/www/2adotcom"
        case imprint
            set dir "$HOME/VS/www/vsbooks"
        case '*'
            echo >&2 "don't know how to go to $destination!"
            return 1
    end
    set destination[1] $dir
    cd (string join / -- $destination)
end
