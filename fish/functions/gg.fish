if in-path ag
    # Use the Silver Searcher
    function gg --wraps ag -d "Plainest search"
        ag --nocolor --nofilename --nonumbers --only-matching $argv
    end
else
    function gg --wraps grep -d "Plainest search"
        grep --recursive --no-filename --only-matching $argv -- ./*
    end
end
