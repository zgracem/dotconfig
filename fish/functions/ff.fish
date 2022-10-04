if in-path fd
    function ff -d "Find files"
        set -p argv --type=f # files only
        set -p argv --glob # glob-based search
        set -p argv --full-path # search against the whole path
        fd $argv
    end
else
    function ff -d "Find files"
        find -H . -xtype f -iname "*$argv*" -print 2>/dev/null
    end
end
