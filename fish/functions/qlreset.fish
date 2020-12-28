if is-macos
    function qlreset --description 'Reset and reload QuickLook'
        qlmanage -r
        and qlmanage -r cache
        and killall Finder
    end
end
