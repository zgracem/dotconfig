function vimdiff --description 'Show differences with Vim'
    if command -sq vimdiff
        command vimdiff $argv
    else
        set -p argv -d
        command vim $argv
    end
end
