in-path fd; and exit

function ff -d "Find files"
    find -H . -xtype f -iname "*$argv*" -print 2>/dev/null
end
