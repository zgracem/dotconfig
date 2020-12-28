function short_home --description 'Replace $HOME with ~ in a path'
    string replace --regex "^$HOME(?=\$|/)" "~" $argv
end
