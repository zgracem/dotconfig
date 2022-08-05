if is-gnu rm
    function rm --description 'Remove directory entries'
        set -p argv -I
        set -p argv -v
        command rm $argv
    end
else
    function rm --description 'Remove directory entries'
        set -p argv -i
        set -p argv -v
        command rm $argv
    end
end
