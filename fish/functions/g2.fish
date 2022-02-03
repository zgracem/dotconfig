function g2 --description 'Go somewhere' -a alias
    set -l destination (string split / --max=1 -- $alias)

    set -l steam_dir "$HOME/Library/Application Support/Steam"
    set -l dropbox "$HOME/Dropbox"

    set -l dir
    switch $destination[1]
        case proj
            set dir "$HOME/Projects"
        case stow
            set dir "$HOME/opt/stow"
        case defunct
            set dir "$HOME/old/src"
        case scratch
            set dir "$HOME/tmp/_scratch"
        case vs9
            set dir "$HOME/VS/www/vsdotcom"
        case imprint
            set dir "$HOME/VS/www/vsbooks"
        case 2a
            set dir "$HOME/VS/www/2adotcom"
        case desktop
            set dir "$XDG_DESKTOP_DIR"
        case dl
            set dir "$XDG_DOWNLOAD_DIR"
        case git
            set dir "$HOME/GitHub"
        case hub
            set dir "$HOME/.local/src/github.com"
        case ruby
            set dir "$dropbox/dev/ruby"
        case scripts
            set dir "$dropbox/dev/shell"
        case steam
            set dir "$steam_dir"
        case steamapps
            set dir "$steam_dir/steamapps"
        case steamuser
            set dir "$steam_dir/userdata"
        case '*'
            echo >&2 "don't know how to go to $destination!"
            return 1
    end
    set destination[1] $dir
    cd (string join / -- $destination)
end
