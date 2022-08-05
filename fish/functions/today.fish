function today -d "Find files modified today"
    if command -sq fd
        fd --changed-within 24h $argv
    else
        find -mtime -1 $argv
    end
end
