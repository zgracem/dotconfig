# -----------------------------------------------------------------------------
# ~zozo/.config/bash/completion
# say hello: printf "zozo\x40inescapable\x2eorg"
# -----------------------------------------------------------------------------

# only run if we need to
[[ $BASH_COMPLETION_SOURCED ]] &&
    return

# -----------------------------------------------------------------------------
# shell options
# -----------------------------------------------------------------------------

# include .dotfiles in filename expansion
shopt -s dotglob

# perform hostname completion on strings containing '@'
shopt -s hostcomplete

# don't search PATH when completion is attempted on an empty line
shopt -s no_empty_cmd_completion

# -----------------------------------------------------------------------------
# bash-completion
# -----------------------------------------------------------------------------

for checkFile in /{{usr,opt}/local/,}etc/bash_completion; do
    if [[ -r $checkFile ]]; then
        . "$checkFile"
        BASH_COMPLETION_SOURCED="$checkFile"
        break
    fi
done

unset checkFile

# -----------------------------------------------------------------------------
# my custom completions
# -----------------------------------------------------------------------------

# complete actions:
# -a    alias           #       function
# -b    builtin         #       helptopic
# -c    command         #       hostname [from $HOSTFILE]
# -d    directory       # -j    job [name]
# -e    export[ed var]  # -k    keyword
# -f    file [names]    # -v    variable

complete -bk    -A helptopic    help
complete -defv  -A hostname     scp sftp ssh
complete -abcdf -A function     sudo
complete -aev   -A function     unset
complete -abcfk -A function \
                -A helptopic    type which what h
complete -A function            fe where
complete -def                   trash
complete -A shopt               _shoptSet

# reloading config files with `rl`
complete -o nospace -W "profile bashrc ${dotfiles[*]}" rl

# kill running processes
_inPath killall && {
    __complete_killall()
    {
        declare processes=($(command ps -cxo command))
        declare cur=${COMP_WORDS[COMP_CWORD]}
        COMPREPLY=( $(compgen -W "${processes[*]}" -- $cur) )
    }

    complete -F __complete_killall killall
}

# edit scripts
__complete_edsh()
{
    declare cur=${COMP_WORDS[COMP_CWORD]}
    declare scripts=( $(find -H "$dir_scripts" -maxdepth 2 -type f -name '*.sh' | sed -nE 's#^.*/(.*)\.sh$#\1#p') )

    COMPREPLY=( $(compgen -W "${scripts[*]}" -- $cur) )
}

complete -F __complete_edsh edsh

# -----------------------------------------------------------------------------
# misc. custom completions
# -----------------------------------------------------------------------------

# SSH hostnames from ~/.ssh/config, ignoring wildcards
# https://github.com/pahen/dotfiles/blob/master/.completions
if [[ -r $HOME/.ssh/config ]]; then
    complete -o default -o nospace \
             -W "$(sed -nE 's/Host (.*[^?*])$/\1/p' $HOME/.ssh/config)" \
             scp sftp ssh
fi

# transmission-remote-cli (https://github.com/fagga/transmission-remote-cli)
_source "$dir_mybin/transmission-remote-cli/completion/bash/transmission-remote-cli-bash-completion.sh"

# others
for file in $dir_config/bash/completion/*.sh; do
    _source "$file"
    unset file
done
