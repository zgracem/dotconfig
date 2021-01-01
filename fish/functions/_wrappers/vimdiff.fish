function vimdiff --description 'Show differences with Vim'
    if in-path vimdiff
        command vimdiff $argv
    else
        command vim -d $argv
    end
end
