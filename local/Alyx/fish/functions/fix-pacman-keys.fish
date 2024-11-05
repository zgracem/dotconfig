function fix-pacman-keys
    # Needed after (some) SteamOS updates. Fixes error:
    #   `signature from "GitLab CI Package Builder
    #   <ci-package-builder-1@steamos.cloud>" is unknown trust`
    sudo pacman-key --init
    sudo pacman-key --populate archlinux
    sudo pacman-key --populate holo
end
