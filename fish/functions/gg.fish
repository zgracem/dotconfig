if in-path ag
    # Use the Silver Searcher
    function gg --wraps ag
        ag $argv
    end
else
    function gg --wraps grep --description 'Search files and directories in PWD'
        grep --line-number --recursive $argv -- ./*
    end
end
