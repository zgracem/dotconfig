function compsrc -d 'Display completion source file(s)' -a query
    for file in $fish_complete_path/$query.fish
        path is -f $file; and set -f found something; and short_home $file
    end
    string match -q something "$found"
end
