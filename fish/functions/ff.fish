command -q fd; and return
fish-is-older-than 3.6; or return

function ff -d "Find files"
    find -H . -xtype f -iname "*$argv*" -print 2>/dev/null
end
