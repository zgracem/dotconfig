function short_home --description 'Replace $HOME with ~ in a path'
    for path in $argv
        string replace --regex "^$HOME(?=\$|/)" "~" $path
    end
end
