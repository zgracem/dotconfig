function g2 --description 'Go somewhere' --argument destination
  switch $destination
    case 'defunct'; cd "$HOME/src/_defunct"
    case 'stow';    cd "$HOME/opt/stow"
    case 'inbox';   cd "$HOME/Dropbox/inbox"
    case 'scratch'; cd "$HOME/tmp/_scratch"
    case 'vs9';     cd "$HOME/Dropbox/www/vs2017"
    case 'imprint'; cd "$HOME/www/2018/imprint"
    case 'proj';    cd "$HOME/Dropbox/Projects"
    case '*';       return 1
  end
end
