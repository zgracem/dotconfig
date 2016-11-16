# -----------------------------------------------------------------------------
# aliases
# -----------------------------------------------------------------------------

alias    ba='_edit $dir_config/bash/bashrc.d/aliases.bash'
alias   brc='_edit $dir_config/bash/bashrc.bash'
alias bpath='_edit $dir_config/sh/paths.sh'
alias  bps1='_edit $dir_config/bash/bashrc.d/prompt.bash'

# -----------------------------------------------------------------------------
# functions
# -----------------------------------------------------------------------------

_z_rl_say()
{
  (( verbosity > 0 )) || return
  local msg_fmt="Reloading %s...\n"
  local filename="${1/#$HOME/$'~'}"
  printf "$msg_fmt" "$filename"
}

rl()
{ # note: requires extglob, globstar, nullglob

  export Z_RELOADING=true

  # nullglob interferes with bash-completion, so turn it on only temporarily,
  # and set a trap to make sure it turns off again no matter what
  shopt -q nullglob || trap 'shopt -u nullglob; trap - RETURN;' RETURN
  shopt -s nullglob

  local -a files=()
  local verbosity=${verbosity:+0}

  local OPT OPTIND

  while [[ ${1:0:1} == "-" ]]; do
    if [[ $1 == -d ]]; then
      local dry_run=true
      (( verbosity < 1 && verbosity++ ))
      verbose "> dry run"
      shift
    elif [[ $1 == -+(v) ]]; then
      local v=${1//[^v]/}
      verbosity=${#v}
      verbose 2 ">> verbosity level: ${verbosity}"
      shift
    else
      # meaningless switch, discard
      shift
    fi
  done

  # Used in .bashrc
  (( verbosity > 0 )) && export Z_RL_VERBOSE=true

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

      colour) # also reload prompt
          files+=("$dir_config/bash/bashrc.d/prompt.bash")
          ;;

      functions)
          files+=("$dir_config/bash/functions.d/"*.bash)
          ;;

      local) 
          files+=("$dir_local/config/bashrc.d/"*.bash)
          ;;

      inputrc)
          local inputrc="${INPUTRC:-~/.inputrc}"
          _z_rl_say "$inputrc"
          [[ -z $dry_run ]] && bind -f "$inputrc"
          return
          ;;

      tmux) _inTmux || return
          _z_rl_say "~/.tmux.conf"
          [[ -z $dry_run ]] && tmux source-file ~/.tmux.conf
          return
          ;;
    esac

    if (( ${#files[@]} > 0 )); then
      verbose 2 ">> $(declare -p files)"
    else
      verbose 2 ">> no files found for <$1>, searching functions..."
      # still nothing... maybe it's the name of a function?
      local func; if func=$(where "$1" 2>/dev/null); then
        func=${func%:*}       # remove trailing colon and line no.
        func=${func/#~/$HOME} # tilde-expand filename
        files+=("$func")
      fi
    fi
  fi

  # We don't need nullglob anymore, so turn it off and unset the RETURN trap
  # before using `.` on any files.
  shopt -u nullglob; trap - RETURN

  local f; for f in "${files[@]}"; do
    if [[ -f $f ]]; then
      _z_rl_say "$f"
      if [[ -z $dry_run ]]; then
        if (( verbosity >= 3 )); then
          verbose 3 ">>> begin xtrace";
          set -o xtrace
          . "$f"
          set +o xtrace;
          verbose 3 ">>> end xtrace"
        else
          . "$f"
        fi
      fi
    else
      verbose 2 ">> bad file: <$f>"
    fi
  done

  unset -v Z_RELOADING Z_RL_VERBOSE
  return $ret
}

ef()
{ # find and edit shell functions
  (( $# == 1 )) || return 1

  local func=$1
  local dir="$dir_config/bash"

  if ! _isFunction "$func"; then
    local file="$dir/functions.d/$func.bash"

    if [[ -f $file ]]; then
      _edit "$file"
      return 0
    elif (( ${#FUNCNAME[@]} == 1 )); then
      # we're not being called by another function like es()
      local answer=n

      printf '%s' "$func does not exist. "
      read -e -p "Create it ("${file/#$HOME/$'~'}")? [y/N] " answer

      if [[ $answer =~ [yY] ]]; then
        printf "%s()\n{\n  #function\n}\n" "$func" > "$file"
        _edit "$file:3:5"
        return 0
      else
        return 1
      fi
    else
      # we are being called by another function like es(), so we're done
      return 1
    fi
  else
    local src=$(whencetf "$func")
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

    launchctl load "$plist" || return

    [[ $TERM_PROGRAM == Apple_Terminal ]] && killall Terminal
  }
fi

# -----------------------------------------------------------------------------
# _z_config_symlink
# Symlink files from ~/.config into ~
# -----------------------------------------------------------------------------

# Usage:
#   _z_config_symlink target [symlink]
#
# - TARGET is relative to ~/.config
# - SYMLINK is relative to ~
#   - defaults to the basename of TARGET preceded by a dot
#
# Example: 
#   _z_config_symlink "git/config" ".gitconfig"
#   _z_config_symlink "vimrc"

_z_config_symlink()
{
  local target

  if [[ -e $HOME/.config/$1 ]]; then
    target=".config/$1"
  elif [[ -e $HOME/$1 ]]; then
    target="$1"
  else
    scold "not found: $target"
    return 1
  fi

  if [[ -n $2 ]]; then
    local symlink=$2
  else
    # default to ~/.whatever
    local symlink=".${target##*/}"
  fi

  if [[ -L $HOME/$symlink ]]; then
    # link already exists
    return 0
  elif [[ -f $HOME/$symlink ]]; then
    local backup
    if (( ${BASH_VERSINFO[0]}${BASH_VERSINFO[1]} >= 42 )); then
      printf -v backup "$symlink~original_%(%Y%m%d)T"
    else
      backup="$symlink~original_$(date +%Y%m%d)"
    fi
    mv -v "$HOME/$symlink" "$HOME/$backup" || return
  fi

  ( cd "$HOME"; ln -sv "$target" "$symlink" )
}
