# -----------------------------------------------------------------------------
# aliases
# -----------------------------------------------------------------------------

alias    ba='_edit $dir_config/bash/bashrc.d/aliases.bash'
alias   brc='_edit $dir_config/bash/bashrc.bash'
alias  bcol='_edit $dir_config/bash/colour.bash'
alias bpath='_edit $dir_config/sh/profile.d/paths.sh'
alias bdirs='_edit $dir_config/bash/dirs.bash'
alias  bps1='_edit $dir_config/bash/bashrc.d/prompt.bash'

# -----------------------------------------------------------------------------
# functions
# -----------------------------------------------------------------------------

rl()
{   # note: requires extglob, globstar, nullglob

  export Z_RELOADING=true

  # nullglob interferes with bash-completion, so turn it on only temporarily
  shopt -q nullglob || trap 'shopt -u nullglob; trap - RETURN;' RETURN
  shopt -s nullglob

  local -a files=()
  local ret=1

  if [[ $1 == -d ]]; then
    local dry_run=true
    printf '[%s]\n' "dry run"
    shift
  fi

  if [[ $1 == -v ]]; then
    export Z_RL_VERBOSE=true
    shift
  fi

  if (( $# == 0 )); then
    files+=("$dir_config/bash/profile.bash")
  else
    # search under ~/.config/bash and ~/.config/sh
    files+=("$dir_config/"{bash,sh}/**/"$1"?(.*))

    # check ~/.local
    files+=("$dir_local/config/bashrc.d/$1"?(.*))
    files+=("$dir_local/config/functions.d/$1"?(.*))

    case $1 in
      init)   # normally not sourced on reload
          files+=("$dir_local/config/init.bash")
          ;;

      prompt) # reload colours first
          files=("$dir_config/bash/colour.bash" "${files[@]}")
          ;;

      functions)
          files+=("$dir_config/bash/functions.d/"*.bash)
          ;;

      local)  files+=("$dir_local/config/bashrc.d/"*.bash)
          ;;

      inputrc)
          printf "%s\n" "~/.inputrc"
          [[ -z $dry_run ]] && bind -x 're-read-init-file'
          return
          ;;

      tmux)   _inTmux || return
          printf "%s\n" "~/.tmux.conf"
          [[ -z $dry_run ]] && tmux source-file ~/.tmux.conf
          return
          ;;
    esac

    if (( ${#files[@]} == 0 )); then
      # still nothing... maybe it's the name of a function?
      local func; if func=$(where "$1" 2>/dev/null); then
        files+=(${func%:*})
      fi
    fi
  fi

  shopt -u nullglob; trap - RETURN

  local f; for f in "${files[@]}"; do
    if [[ -f $f ]]; then
      # printf "Reloading %s...\n" "${f/#$HOME/$'~'}"
      [[ -z $dry_run ]] && . "$f" && ret=0
    fi
  done

  unset -v Z_RELOADING Z_RL_VERBOSE
  return $ret
}

ef()
{ # find and edit shell functions
  (( $# == 1 )) || return $EX_USAGE

  local func=$1
  local dir="$dir_config/bash"

  if ! _isFunction "$func"; then
    local file="$dir/functions.d/$func.bash"

    if [[ -f $file ]]; then
      _edit "$file"
      return $EX_OK
    elif (( ${#FUNCNAME[@]} == 1 )); then
      # we're not being called by another function like edsh()
      local answer=n

      printf '%s' "$func does not exist. "
      read -e -p "Create it ("${file/#$HOME/$'~'}")? [y/N] " answer

      if [[ $answer =~ [yY] ]]; then
        printf "%s()\n{\n  #function\n}\n" "$func" > "$file"
        _edit "$file:3:5"
        return $EX_OK
      else
        return $EX_ABORT
      fi
    else
      # we are being called by another function like es(), so we're done
      return 1
    fi
  else
    local src=$(where "$func")
    local src_file=${src%:*}
    local src_line=${src#*:}

    src_file=${src_file/#~/$HOME}

    if [[ -f $src_file ]]; then
      _edit "${src_file}:${src_line}"
    fi
  fi
}

if _inPath launchctl; then
  rlenv()
  { # reload OS-wide environment variables (GUI apps will require restart)
    local plist="$HOME/Library/LaunchAgents/org.inescapable.environment.plist"

    if [[ ! -e $plist ]]; then
      ln -sv "$HOME/Dropbox/.config/misc/${plist##*/}" || return
    else
      launchctl unload "$plist" || return
    fi

    launchctl load "$plist"

    [[ $TERM_PROGRAM == Apple_Terminal ]] && killall Terminal
  }
fi

# -----------------------------------------------------------------------------
# z::config::symlink
# Symlink files from ~/.config into ~
# -----------------------------------------------------------------------------

# Usage:
#   z::config::symlink target [symlink]
#
# - TARGET is relative to ~/.config
# - SYMLINK is relative to ~
#   - defaults to the basename of TARGET preceded by a dot
#
# Example: 
#   z::config::symlink "git/config" ".gitconfig"
#   z::config::symlink "vimrc"

z::config::symlink()
{
  local target=".config/${1}"

  if [[ -n $2 ]]; then
    local symlink=$2
  else
    # default to ~/.whatever
    local symlink=".${target##*/}"
  fi

  if [[ ! -e $HOME/$target ]]; then
    scold "not found: $HOME/$target"
    return 1
  fi

  if [[ ! -L $HOME/$symlink ]]; then
    if [[ -f $HOME/$symlink ]]; then
      local backup
      printf -v backup "$symlink~original_%(%Y%m%d)T"
      mv -v "$HOME/$symlink" "$HOME/$backup" || return
    fi

    ( cd "$HOME"; ln -sv "$target" "$symlink" )
  else
    # symlink already exists
    return 0
  fi
}
