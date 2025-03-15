function mansrc -d 'Display manual page source file(s)'
    if test -z "$argv"
        command man -aw | string split : | path filter
        return
    end
    for page in (command man -aw $argv)
        path is $page
        and short_home $page
    end
end
