function funcsrc -d 'Display function source file(s)' -a query
    if test -z "$query"
        short_home $fish_function_path
        return
    end
    set --function found nothing
    for file in $fish_function_path/$query.fish
        path is -f $file; and set found something; and short_home $file
    end
    string match -q nothing $found; and functions -D $query; or return 0
end
