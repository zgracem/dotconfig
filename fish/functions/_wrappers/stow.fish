in-path stow; or exit

function stow -d "manage farms of symbolic links"
    set -p argv --verbose
    command stow $argv
end
