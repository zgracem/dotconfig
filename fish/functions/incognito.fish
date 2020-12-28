function incognito --description "Toggle fish's private mode on and off"
    if set -q fish_private_mode
        exec fish
    else
        exec fish --private
    end
end
