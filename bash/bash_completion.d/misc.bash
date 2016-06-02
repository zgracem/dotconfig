# -----------------------------------------------------------------------------
# simple custom completions
# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------
# complete actions (-A)
# -----------------------------------------------------------------------------

# GENERAL:
# - directory       -d    # - binding [readline]
# - file            -f    # - hostname [from $HOSTFILE]

# COMMANDS:               # SYSTEM/SHELL:
# - alias           -a    # - group
# - builtin         -b    # - service         -s
#   - disabled            # - setopt
#   - enabled             # - shopt
# - command         -c    # - signal
# - function              # - user            -u
# - helptopic             
# - keyword         -k  

# JOB CONTROL:            # VARIABLES:
# - job             -j    # - arrayvar
#   - running             # - export[ed var]  -e
#   - stopped             # - variable        -v

# OPTIONS (-o):
# - if compspec generates no matches, fall back to:
#   - bashdefault   default bash completions
#   - default       default readline filename completion
#   - dirnames      directory name completion
# - filenames       process completions as filenames
# - plusdirs        add directories to list of completions
# - noquote         don't quote filenames
# - nosort          don't sort completions alphabetically
# - nospace         don't add trailing space

# -----------------------------------------------------------------------------

# aliases -- for `alias` & `unalias`
complete -a \
    alias unalias

# directories & variables -- for `cd`
complete -d -ev \
    -o nospace \
    cd

# builtins, keywords & help topics -- for `help`
complete -bk -A helptopic \
    -o nospace \
    help

# variables, aliases & functions -- for `export` & `unset`
complete -ev -a -A function -- \
    export unset

# variables & functions -- for `declare`
complete -ev -A function \
    declare

# files, directories, variables & hostnames -- for `scp`, `sftp` & `ssh`
complete -fd -ev -A hostname \
    scp sftp ssh

# files, directories, aliases, builtins, commands, keywords & functions -- for `sudo`
complete -fd -abck -A function \
    sudo

# files, aliases, builtins, commands, keywords, functions & help topics -- for `type`
complete -f -abck -A function -A helptopic -- \
    -o nospace \
    type

# custom scripts and functions

# shell options -- for `shopt` and `_shoptSet`
complete -A shopt \
    shopt _shoptSet

# shell options -- for `set` and `_optSet`
complete -A setopt \
    set _optSet

# files & directories -- for `trash`
complete -fd \
    -o filenames \
    trash

# functions -- for `fe`
complete -A function \
    -o nospace \
    fe

# arrays -- for `explode`
complete -A arrayvar \
    -o nospace \
    explode
