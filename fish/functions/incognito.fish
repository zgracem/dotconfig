function incognito --description "Toggle fish's private mode on and off"
    if test -z "$fish_private_mode"
        set --global fish_private_mode on
    else
        set --global --erase fish_private_mode
    end
end
