# Complete SSH hostnames from ~/.ssh/config, ignoring wildcards
# Based on: https://github.com/pahen/dotfiles/blob/master/.completions

if [[ -r $HOME/.ssh/config ]]; then
    declare -a hosts=( $(sed -nE 's/Host (.*[^?*])$/\1/p' "$HOME/.ssh/config") )

    complete -o default -o nospace \
             -W "${hosts[*]}" \
             scp sftp ssh

    unset hosts
fi
