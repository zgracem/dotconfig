# -----------------------------------------------------------------------------
# ~/.config/bash/completion.bash
# -----------------------------------------------------------------------------

# bash-completion v2
export BASH_COMPLETION_DIR="/usr/local/share/bash-completion/completions"

if [[ ! -d $BASH_COMPLETION_DIR ]]; then
  unset BASH_COMPLETION_DIR
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

# -----------------------------------------------------------------------------
# support functions
# -----------------------------------------------------------------------------

__z_complete_files()
{   # Usage: __z_complete_files EXTENSION DIRECTORY... 
  # Returns *.EXTENSION in each DIRECTORY

  local extension="$1"; shift

  local directory; for directory in "$@"; do
    local filename; for filename in "$directory/"*."$extension"; do
      filename=${filename#$directory/}
      filename=${filename%.$extension}
      printf '%q\n' "$filename"
    done
  done
}

__z_complete_src()
{   # Usage: __z_complete_src FILE...

  # track errors
  local x=0

  local f; for f in "$@"; do
    if [[ -f $f ]]; then
      . "$f" || (( x++ ))
    else
      (( x++ ))
    fi
  done

  return $x
}

# __z_complete_thing()
# {
#   local cur=${COMP_WORDS[COMP_CWORD]}
#   local -a wordlist=()
#
#   # other stuff
#
#   COMPREPLY=( $(compgen -W "${wordlist[*]}" -- "$cur" ) )
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

### ZGM removed `man` 2015-11-10 -- was getting _init_completion not found errors
for c in configure curl find tmux wget; do
  __z_complete_src "$HOMEBREW_COMPLETION/$c" \
    || __z_complete_src "$BASH_COMPLETION_DIR/$c"
done

# custom completions
if [[ -d $dir_config/bash/bash_completion.d ]]; then
  for c in "$dir_config"/bash/bash_completion.d/*.bash; do
    __z_complete_src "$c"
  done
fi

unset c
