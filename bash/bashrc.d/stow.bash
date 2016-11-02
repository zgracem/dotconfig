_inPath stow || return

# export STOW_DIR="$HOME/opt/stow"

_z_config_symlink stow/stowrc
_z_config_symlink stow/stow-global-ignore

unstow() { command stow --delete "$@"; }
