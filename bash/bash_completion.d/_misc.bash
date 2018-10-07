# -----------------------------------------------------------------------------
# simple custom completions
# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------
# complete actions (-A)
# -----------------------------------------------------------------------------

# GENERAL:
# - directory   (-d)    # - [readline] binding
# - file        (-f)    # - hostname [from $HOSTFILE]
                                                                            
# COMMANDS:             # SYSTEM/SHELL:
# - alias       (-a)    # - group
# - builtin     (-b)    # - service (-s)
#   - disabled          # - setopt
#   - enabled           # - shopt
# - command     (-c)    # - signal
# - function            # - user    (-u)
# - helptopic         
# - keyword     (-k)  
                                                                            
# JOB CONTROL:          # VARIABLES:
# - job         (-j)    # - arrayvar
#   - running           # - export[ed var]  (-e)
#   - stopped           # - variable        (-v)
                                                                                
# OPTIONS (-o):
# - If compspec generates no matches, fall back to:
#   - bashdefault   Default bash completions
#   - default       Default readline filename completion
#   - dirnames      Directory name completion
# - filenames       Process completions as filenames
# - plusdirs        Add directories to list of completions
# - noquote         Don't quote filenames
# - nosort          Don't sort completions alphabetically
# - nospace         Don't add trailing space

# -----------------------------------------------------------------------------

# aliases
complete -a -- alias unalias

# readline bindings
complete -A -- binding bind

# shell builtins
complete -b -- builtin

# directories & variables
complete -o nospace -dv -- cd

# help topics
complete -o nospace -A helptopic -- help

# hostnames
complete -A hostname -o default -- dig ping

# job control
complete -j -P '"%' -S '"' -- disown fg jobs

# shell options
complete -A setopt -- set
complete -A shopt -- shopt

# variables & functions
complete -v -A function -- declare export typeset unset

# variables only
complete -v -- readonly

# files, directories, aliases, builtins, commands, keywords & functions
complete -fdabck -A function -- sudo

# files, aliases, builtins, commands, keywords, functions & help topics
complete -o nospace -fabck -A function -A helptopic -- type

# -----------------------------------------------------------------------------
# custom scripts and functions
# -----------------------------------------------------------------------------

# variables & functions -- for alias to `declare -p`
complete -v -A function -- d

# files & directories -- for `trash`
complete -o filenames -o plusdirs -fd -- trash

# functions -- for `ef`
complete -o nospace -A function -- ef
