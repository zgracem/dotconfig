if is-gnu chmod
    function chmod --description 'Change the mode of files'
        command chmod --changes $argv
    end
else
    function chmod --description 'Change the mode of files'
        command chmod -v $argv
    end
end
