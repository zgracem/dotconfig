function clean-list -d "Trim whitespace, blank lines, and duplicates from stdin"
     cat | string trim | un1q | string match -erv '^$';
end
