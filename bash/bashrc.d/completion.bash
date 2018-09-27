# -----------------------------------------------------------------------------
# ~/.config/bash/completion.bash
# -----------------------------------------------------------------------------

BASH_COMPLETION_DIR="$XDG_CONFIG_HOME/bash/bash_completion.d"

if [[ -n $HOMEBREW_PREFIX ]]; then
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
COMP_WORDBREAKS=${COMP_WORDBREAKS//:}

# complete hostnames from this file
HOSTFILE="$XDG_CONFIG_HOME/ssh/hosts"

# -----------------------------------------------------------------------------
# support functions
# -----------------------------------------------------------------------------

# template:

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

__z_complete_files()
{ # Usage: __z_complete_files EXT DIR... 
  # Returns *.EXT in each DIR

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
  # shellcheck disable=SC1090
  . "$compspec" &>/dev/null && return 124
}

# -----------------------------------------------------------------------------
# load external completions
# -----------------------------------------------------------------------------

# # bash-completion v2
# BASH_COMPLETION="/usr/local/share/bash-completion/bash_completion"
# [[ -f $BASH_COMPLETION ]] && . "$BASH_COMPLETION"
# unset -v BASH_COMPLETION

# shellcheck disable=SC1090
. "$BASH_COMPLETION_DIR/_misc.bash"

if (( BASH_VERSINFO[0] >= 4 )); then
  # Load completions dynamically
  complete -D -F __z_complete_autoload -o bashdefault -o default
else
  # Load them manually
  unset -f __z_complete_autoload
  for file in "$BASH_COMPLETION_DIR"/[^_]*.bash; do
    # shellcheck disable=SC1090
    [[ -f $file ]] && . "$file"
  done
  unset -v file
fi

unset -v BASH_COMPLETION_DIR HOMEBREW_COMPLETION
