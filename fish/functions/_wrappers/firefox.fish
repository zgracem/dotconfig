if is-macos
    function firefox --description 'Launch Mozilla Firefox'
        open -b org.mozilla.firefox $argv
    end
end
