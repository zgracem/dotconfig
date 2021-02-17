function g2 --description 'Go somewhere' -a alias
    set -l destination (string split / --max=1 -- $alias)
    set -l dir
    switch $destination[1]
        case inbox
            set dir "$HOME/Dropbox/inbox"
        case proj
            set dir "$HOME/Dropbox/Projects"
        case stow
            set dir "$HOME/opt/stow"
        case defunct
            set dir "$HOME/Dropbox/src.old"
        case scratch
            set dir "$HOME/tmp/_scratch"
        case vs9
            set dir "$HOME/Dropbox/VS/www/vsdotcom"
        case imprint
            set dir "$HOME/Dropbox/VS/www/vsbooks"
        case 2a
            set dir "$HOME/Dropbox/VS/www/2adotcom"
        case desktop
            set dir "$XDG_DESKTOP_DIR"
        case dl
            set dir "$XDG_DOWNLOAD_DIR"
        case '*'
            echo >&2 "don't know how to go to $destination!"
            return 1
    end
    set destination[1] $dir
    cd (string join / -- $destination)
end
