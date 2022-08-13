function thisweek -d "Find files modified this week"
    if in-path fd
        fd --changed-within 7d $argv
    else
        find -mtime -7 $argv
    end
end
