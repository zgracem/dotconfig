function incognito --description "Toggle fish's private mode on and off"
    argparse on off -- $argv

    if set -q _flag_on
        set --global fish_private_mode on
        return
    else if set -q _flag_off
        set --global --erase fish_private_mode
        return
    end

    if set -q fish_private_mode
        set --global --erase fish_private_mode
    else
        set --global fish_private_mode on
    end
end
