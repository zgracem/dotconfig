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
    source "$checkFile" 2>/dev/null && {
        export BASH_COMPLETION_SOURCED="$checkFile"
        break
    }

    unset checkFile
done

# -----------------------------------------------------------------------------
# my custom completions
# -----------------------------------------------------------------------------

# complete actions:
# -a    alias           #       function
# -b    builtin         #       helptopic
# -c    command         #       hostname (from $HOSTFILE)
# -d    directory       # -j    job (name)
# -e    export(ed var)  # -k    keyword
# -f    file (names)    # -v    variable

complete -bck                   command
complete -abcfk -A function -A helptopic \
                                man type what which
complete -A function            fe where
complete -defv -A hostname      scp sftp ssh
complete -abcf -A function      sudo
complete -defv                  trash
complete -aev -A function       unset

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

    complete -o default -o nospace \
             -F __complete_killall \
             killall
}

# edit scripts
__complete_edsh()
{
    declare cur=${COMP_WORDS[COMP_CWORD]}
    declare scripts=( $(find -H "$dir_scripts" -maxdepth 2 -type f -name '*.sh' | sed -nE 's#^.*/(.*)\.sh$#\1#p') )

    COMPREPLY=( $(compgen -W "${scripts[*]}" -- $cur) )
}

complete -o default -o nospace \
    -F __complete_edsh \
    edsh

# -----------------------------------------------------------------------------
# misc. custom completions
# -----------------------------------------------------------------------------

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
# https://github.com/pahen/dotfiles/blob/master/.completions
[[ -f $HOME/.ssh/config ]] && {
    complete -o default -o nospace \
             -W "$(sed -nE 's/Host (.*[^?*])$/\1/p' $HOME/.ssh/config)" \
             scp sftp ssh
}

# Homebrew
[[ -x /usr/local/bin/brew ]] &&
    _source "$(brew --prefix)/Library/Contributions/brew_bash_completion.sh"

# Transmission
_source "$dir_mybin/transmission-remote-cli/transmission-remote-cli-bash-completion.sh"

