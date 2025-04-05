function funcsrc -d 'Display function source file(s)'
    if test -z "$argv"
        if isatty stdout
            short_home $fish_function_path
        else
            echo -ns $fish_function_path\n
        end
        return
    end
    set -f found nothing
    for file in $fish_function_path/$argv.fish
        if path is $file
            set -f found something
            if isatty stdout
                short_home $file
            else
                echo $file
            end
        end
    end
    string match -q something "$found"
end
