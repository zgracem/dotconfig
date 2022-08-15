function rm --description 'Remove directory entries'
    if status is-interactive
        if is-gnu rm
            set -p argv -I # prompt before large operations
        else
            set -p argv -i # request confirmation before each file
        end
    end
    set -p argv -v # verbose
    command rm $argv
end
