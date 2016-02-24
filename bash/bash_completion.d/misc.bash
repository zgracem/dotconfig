# -----------------------------------------------------------------------------
# simple custom completions
# -----------------------------------------------------------------------------

# complete actions:
#   alias           -a
#   builtin         -b
#   command         -c
#   directory       -d
#   export[ed var]  -e
#   file            -f
#   function                    
#   helptopic                   
#   hostname [from $HOSTFILE]   
#   job [name]      -j
#   keyword         -k
#   variable        -v

complete -a \
    alias unalias

complete -d -ev \
    -o nospace \
    cd

complete -bk -A helptopic \
    -o nospace \
    help

complete -ev -a -A function -- \
    export unset

complete -ev -A function \
    declare

complete -fd -ev -A hostname \
    scp sftp ssh

complete -fd -abck -A function \
    sudo

complete -f -abck -A function -A helptopic -- \
    -o nospace \
    type

# custom scripts and functions

complete -A shopt \
    -o nospace \
    _shoptSet

complete -fd \
    trash

complete -A function \
    -o nospace \
    fe

complete -ev \
    -o nospace \
    explode
