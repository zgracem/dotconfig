if is-gnu chmod
    function chmod --description 'Change the mode of files'
        set -p argv --changes
        command chmod $argv
    end
else
    function chmod --description 'Change the mode of files'
        set -p argv -v
        command chmod $argv
    end
end
