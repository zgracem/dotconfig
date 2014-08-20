# -----------------------------------------------------------------------------
# ~zozo/.config/bash/completion
# say hello: printf "zozo\x40inescapable\x2eorg"
# -----------------------------------------------------------------------------

# only run if we need to
[[ $BASH_COMPLETION_SOURCED ]] \
	&& return

# -----------------------------------------------------------------------------
# shell options
# -----------------------------------------------------------------------------

# include .dotfiles in filename expansion
shopt -s dotglob

# perform hostname completion on strings containing '@'
shopt -s hostcomplete

# don't search PATH when completion is attempted on an empty line
shopt -s no_empty_cmd_completion

# ignore these suffixes when searching for completions
FIGNORE="DS_Store:~:.swp:Application Scripts"

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
complete -v                     whatvar wv

# reloading config files with `rl`
complete -o nospace -W "profile bashrc ${dotfiles[*]}" rl

# -----------------------------------------------------------------------------
# misc. custom completions
# -----------------------------------------------------------------------------

# transmission-remote-cli (https://github.com/fagga/transmission-remote-cli)
_source "${dir_mybin}/github/transmission-remote-cli/completion/bash/transmission-remote-cli-bash-completion.sh"

# t (https://github.com/sferik/t)
_source "${dir_mybin}/github/t/etc/t-completion.sh"

# others
_source "$dir_config"/bash/completion/*.bash
