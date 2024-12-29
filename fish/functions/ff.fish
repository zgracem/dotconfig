function ff -d "Find files"
    if command -q fd
        fd --type=f $argv
    else
        find -H . -xtype f -iname "*$argv*" -print 2>/dev/null
    end
end
