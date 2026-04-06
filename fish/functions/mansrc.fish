function mansrc -d 'Display manual page source file(s)'
    if test -z "$argv"
        set -l man_path (command man -aw | string split :)
        echo -ns $man_path\n
        return
    end
    set -f found nothing
    for file in (command man -aw $argv)
        if path is $file
            set -f found something
            echo $file
        end
    end
    string match -q something "$found"
end
