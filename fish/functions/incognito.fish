function incognito --description "Toggle fish's private mode on and off"
    if fish-is-older-than 3.1.2
        if set -q fish_private_mode
            exec fish
        else
            exec fish --private
        end
    else
        if test -z "$fish_private_mode"
            set --global fish_private_mode on
        else
            set --global --erase fish_private_mode
        end
    end
end
