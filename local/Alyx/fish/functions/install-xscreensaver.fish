function install-xscreensaver
    # Needed after SteamOS updates
    if path is -x /usr/bin/xscreensaver
        echo >&2 "xscreensaver is already installed!"
        return
    end

    sudo steamos-readonly disable
    sudo pacman --sync --refresh --noconfirm xscreensaver
    sudo steamos-readonly enable
end
