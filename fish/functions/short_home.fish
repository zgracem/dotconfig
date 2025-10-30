function short_home --description 'Replace $HOME with ~ in a path'
    if functions -q my-prompt-pwd
        my-prompt-pwd -Z $argv
    else
        string replace --regex "^$HOME(?=\$|/)" "~" $argv
    end
end
