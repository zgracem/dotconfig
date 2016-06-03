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
  elif [[ $1 == -v ]]; then
    export Z_RELOADING_VERBOSE=true
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
      printf "Reloading %s...\n" "${f/#$HOME/$'~'}"
      [[ -z $dry_run ]] && . "$f" && ret=0
    fi
  done

  unset -v Z_RELOADING Z_RELOADING_VERBOSE
  return $ret
}

alias ba='_edit       $dir_config/bash/bashrc.d/aliases.bash'
alias brc='_edit      $dir_config/bash/bashrc.bash'
alias bcol='_edit     $dir_config/bash/colour.bash'
alias bf='_edit       $dir_config/bash/functions.bash'
alias bloc='_edit     $dir_local/config/bashrc.bash'
alias bpath='_edit    $dir_config/sh/profile.d/paths.sh'
alias bdirs='_edit    $dir_config/bash/dirs.bash'
alias bpri='_edit     $dir_config/bash/private.bash'
alias bpro='_edit     $dir_config/bash/profile.bash'
alias bps1='_edit     $dir_config/bash/bashrc.d/prompt.bash'
alias brewfile='_edit $dir_config/brew/Brewfile'
alias inputrc='_edit  $dir_config/inputrc'
alias vimrc='_edit    $dir_config/vimrc'

z::new_function()
{
  if [[ ${FUNCNAME[1]} == fe && -n $func && -n $file && ! -f $file ]]; then
    cat > "$file" <<EOF
${func}()
{
  #function
}
EOF
  else
    return $EX_SOFTWARE
  fi
}

fe()
{ # find and edit a function
  (( $# == 1 )) || return $EX_USAGE

  local func=$1
  local dir="$dir_config/bash"

  if ! _isFunction "$func"; then
    local file="$dir/functions.d/$func.bash"

    if [[ -f $file ]]; then
      _edit "$file"
      return $EX_OK
    else
      local answer=n

      printf '%s' "$func does not exist. "
      read -e -p "Create it ("${file/#$HOME/$'~'}")? [y/N] " answer

      if [[ $answer =~ [yY] ]]; then
        z::new_function
        _edit "$file:3:5"
        return $EX_OK
      else
        return $EX_ABORT
      fi
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
    local plist=~/Library/LaunchAgents/org.inescapable.environment.plist

    launchctl unload "$plist" \
      && launchctl load "$plist"

    [[ $TERM_PROGRAM == Apple_Terminal ]] && killall Terminal
  }
fi
