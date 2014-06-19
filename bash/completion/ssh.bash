# ------------------------------------------------------------------------------
# ~zozo/.config/bash/completion/ssh.bash
# Complete SSH hostnames from ~/.ssh/config, ignoring wildcards
# Based on: https://github.com/pahen/dotfiles/blob/master/.completions
# -----------------------------------------------------------------------------

if [[ -r $HOME/.ssh/config ]]; then
    complete -o default -o nospace \
             -W "$(sed -nE 's/Host (.*[^?*])$/\1/p' $HOME/.ssh/config)" \
             scp sftp ssh
fi
