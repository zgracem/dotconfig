if is-macos
    function lscleanup --description 'Clean up the Launch Services database'
        lsregister -v -kill -r -domain local,system,user
        and killall Finder
    end
end
