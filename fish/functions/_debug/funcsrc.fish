function funcsrc -d 'Display function source file(s)' -a query
    for file in $fish_function_path/$query.fish
        test -f "$file"; and short_home "$file"
    end
    or functions -D $query
end
