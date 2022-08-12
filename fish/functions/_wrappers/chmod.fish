function chmod --description 'Change the mode of files'
    if is-gnu chmod
        set -p argv --changes # show only changes
    else
        set -p argv -v # show all operations
    end
    command chmod $argv
end
