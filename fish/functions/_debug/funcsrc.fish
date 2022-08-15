function funcsrc -d 'Display function source file(s)' -a query
    set --function found nothing
    for file in $fish_function_path/$query.fish
        path is -f $file; and set found something; and short_home $file
    end
    string match -q nothing $found; and functions -D $query
end
