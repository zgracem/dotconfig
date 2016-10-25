scratch()
{ # create a temporary directory and change into it
  # >> https://github.com/tejr/dotfiles/blob/master/bash/bashrc.d/scr.bash

  local dir
  local template="${1:-scratch}"

  if _isGNU mktemp; then
    template+='.XXXXXXXX'
  fi

  dir="$(mktemp -d -t ${template})" || return 1

  if [[ -d $dir ]]; then
    cd "$dir"
  else
    return 1
  fi
}
