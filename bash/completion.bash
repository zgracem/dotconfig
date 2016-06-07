# -----------------------------------------------------------------------------
# ~/.config/bash/completion.bash
# -----------------------------------------------------------------------------

# bash-completion v2
export BASH_COMPLETION_DIR="/usr/local/share/bash-completion/completions"

if [[ ! -d $BASH_COMPLETION_DIR ]]; then
  unset -v BASH_COMPLETION_DIR
fi

# Homebrew
if [[ -n $HOMEBREW_PREFIX ]]; then
  export HOMEBREW_COMPLETION="$HOMEBREW_PREFIX/etc/bash_completion.d"
fi

# -----------------------------------------------------------------------------
# completion options
# -----------------------------------------------------------------------------

shopt -s dotglob                 # include .dotfiles in filename expansion
shopt -s hostcomplete            # do hostname completion on strings containing '@'
shopt -s no_empty_cmd_completion # ignore completion attempts on empty lines

if [[ $OSTYPE =~ cygwin ]]; then
  # use the short name of programs when Tab-completing
  shopt -s completion_strip_exe 2>/dev/null

  # do not consider these files executable for completion purposes
  EXECIGNORE='*.dll:*.sys'
fi

# ignore these suffixes when searching for completions
FIGNORE="DS_Store:~:.swp:Application Scripts"

# do not treat colon specially
#   see question E13: http://tiswww.case.edu/php/chet/bash/FAQ
COMP_WORDBREAKS=${COMP_WORDBREAKS//:}

# -----------------------------------------------------------------------------
# support functions
# -----------------------------------------------------------------------------

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

# -----------------------------------------------------------------------------
# template function
# -----------------------------------------------------------------------------

# __z_complete_thing()
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
# complete -F __z_complete_thing thing

# -----------------------------------------------------------------------------
# load external completions
# -----------------------------------------------------------------------------

### ZGM disabled 2015-10-29 -- performance reasons, let's see if we miss it
# # bash-completion
# if [[ -e /usr/local/share/bash-completion/bash_completion ]]; then
#     . /usr/local/share/bash-completion/bash_completion
# fi

# custom completions
if [[ -d $dir_config/bash/bash_completion.d ]]; then
  for cf in "$dir_config"/bash/bash_completion.d/*.bash; do
    [[ -f $cf ]] && . "$cf"
  done
fi

unset -v cf
