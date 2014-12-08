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

complete -a                     alias unalias
complete -bk    -A helptopic    help
complete -aev   -A function --  export unset
complete -abcfk -A function \
                -A helptopic -- type

complete -defv  -A hostname     scp sftp ssh
complete -abcdf -A function     sudo

complete -A shopt               _shoptSet
complete -def                   trash
complete -A function            fe
complete -v                     explode

# -----------------------------------------------------------------------------
# misc. custom completions
# -----------------------------------------------------------------------------

# transmission-remote-cli (https://github.com/fagga/transmission-remote-cli)
# _source "${dir_mybin}/github/transmission-remote-cli/completion/bash/transmission-remote-cli-bash-completion.sh"

# t (https://github.com/sferik/t)
# _source "${dir_mybin}/github/t/etc/t-completion.sh"
