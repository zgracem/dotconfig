if in-path rg
    # Use ripgrep
    function gg --wraps rg -d "Plainest search"
        rg --color=never --no-filename --no-line-number --only-matching $argv
    end
else if in-path ag
    # Use the Silver Searcher
    function gg --wraps ag -d "Plainest search"
        ag --nocolor --nofilename --nonumbers --only-matching $argv
    end
else
    function gg --wraps grep -d "Plainest search"
        grep --recursive --no-filename --only-matching $argv -- ./*
    end
end
