function compsrc -d 'Display completion source file(s)'
    if test -z "$argv"
        if isatty stdout
            short_home $fish_complete_path
        else
            echo -ns $fish_complete_path\n
        end
        return
    end
    set -f found nothing
    for file in $fish_complete_path/$argv.fish
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
