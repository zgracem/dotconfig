function incognito --description "Toggle fish's private mode on and off"
    argparse on off -- $argv

    if set -q _flag_on
        _incognito_on
        return
    else if set -q _flag_off
        _incognito_off
        return
    end

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

function _incognito_on -d "Force incognito mode on"
    if fish-is-older-than 3.1.2
        exec fish --private
    else
        set --global fish_private_mode on
    end
end

function _incognito_off -d "Force incognito mode off"
    if fish-is-older-than 3.1.2
        exec fish
    else
        set --global --erase fish_private_mode
    end
end
