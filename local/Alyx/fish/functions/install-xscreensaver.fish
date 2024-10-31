function install-xscreensaver
    # Needed after SteamOS updates
    sudo steamos-readonly disable
    sudo pacman -Sy xscreensaver
    sudo steamos-readonly enable
end
