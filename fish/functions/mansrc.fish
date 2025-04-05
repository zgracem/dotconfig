function mansrc -d 'Display manual page source file(s)'
    if test -z "$argv"
        set -l man_path (command man -aw | string split :)
        if isatty stdout
            short_home $man_path
        else
            echo -ns $man_path\n
        end
        return
    end
    set -f found nothing
    for file in (command man -aw $argv)
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
