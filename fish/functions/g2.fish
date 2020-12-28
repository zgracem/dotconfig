function g2 --description 'Go somewhere' -a destination
    switch $destination
        case inbox
            cd "$HOME/Dropbox/inbox"
        case proj
            cd "$HOME/Dropbox/Projects"
        case stow
            cd "$HOME/opt/stow"
        case defunct
            cd "$HOME/Dropbox/Archive/src"
        case scratch
            cd "$HOME/tmp/_scratch"
        case vs9
            cd "$HOME/Dropbox/www/vs2017"
        case imprint
            cd "$HOME/www/2018/imprint"
        case 2a
            cd "$HOME/www/2018/2a18"
        case desktop
            cd "$XDG_DESKTOP_DIR"
        case dl
            cd "$XDG_DOWNLOAD_DIR"
        case '*'
            return 1
    end
end
