# -----------------------------------------------------------------------------
# ~/.config/bash/completion.bash
# -----------------------------------------------------------------------------

BASH_COMPLETION_DIR="$XDG_CONFIG_HOME/bash/bash_completion.d"

if [[ -d $HOMEBREW_PREFIX ]]; then
  export HOMEBREW_COMPLETION="$HOMEBREW_PREFIX/etc/bash_completion.d"
fi

# -----------------------------------------------------------------------------
# completion options
# -----------------------------------------------------------------------------

shopt -s dotglob                 # include .dotfiles in filename expansion
shopt -s hostcomplete            # do hostname completion on strings containing '@'
shopt -s no_empty_cmd_completion # ignore completion attempts on empty lines

if [[ $PLATFORM == windows ]]; then
  # use the short name of programs when Tab-completing
  shopt -s completion_strip_exe 2>/dev/null

  # do not consider these files executable for completion purposes
  EXECIGNORE='*.dll:*.sys'
fi

# ignore these suffixes when searching for completions
FIGNORE="DS_Store:~:.swp:Application Scripts"

# do not treat colon specially
# >> http://tiswww.case.edu/php/chet/bash/FAQ [question E13]
COMP_WORDBREAKS=${COMP_WORDBREAKS//:/}

# complete hostnames from this file
HOSTFILE="$HOME/.ssh/hosts"

# -----------------------------------------------------------------------------
# support functions
# -----------------------------------------------------------------------------

##### template #####
# __z_complete_THING()
# {
#   local cmd=$1
#   local cur=${COMP_WORDS[COMP_CWORD]}
#   local prev=${COMP_WORDS[COMP_CWORD-1]}
#   local -a wordlist=()
#
#   # other stuff
#
#   COMPREPLY=( $(compgen -W "${wordlist[*]}" -- "$cur") )
# }
#
# complete -F __z_complete_THING THING
#
##### end template #####

__z_complete_filenames()
{ # Usage: __z_complete_filenames EXT DIR...
  # Returns *.EXT, minus .EXT, in each DIR

  local extension="$1"; shift

  local directory; for directory in "$@"; do
    local filename; for filename in "$directory/"*."$extension"; do
      filename=${filename#$directory/}
      filename=${filename%.$extension}
      printf '%q\n' "$filename"
    done
  done
}

__z_complete_autoload()
{ # Set this function as the default completion handler to autoload compspecs:
  #   complete -D -F __z_complete_autoload -o bashdefault -o default
  # >> sanctum.geek.nz/cgit/dotfiles.git/tree/bash/bashrc.d/completion.bash
  [[ -n $1 ]] || return
  local compspec="$XDG_CONFIG_HOME/bash/bash_completion.d/$1.bash"
  [[ -f $compspec ]] || return
  . "$compspec" &>/dev/null && return 124
}

# -----------------------------------------------------------------------------
# misc. completions
# -----------------------------------------------------------------------------

# aliases
complete -a -- alias unalias

# readline bindings
complete -A binding -- bind

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
