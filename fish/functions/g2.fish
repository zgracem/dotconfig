function g2 --description 'Go somewhere' --argument destination
  switch $destination
    case 'inbox';   cd "$HOME/Dropbox/inbox"
    case 'proj';    cd "$HOME/Dropbox/Projects"
    case 'stow';    cd "$HOME/opt/stow"
    case 'defunct'; cd "$HOME/src/_defunct"
    case 'scratch'; cd "$HOME/tmp/_scratch"
    case 'vs9';     cd (realpath "$HOME/www/2017/vs9")
    case 'imprint'; cd "$HOME/www/2018/imprint"
    case '2a';      cd "$HOME/www/2018/2a18"
    case '*';       return 1
  end
end
