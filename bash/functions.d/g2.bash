declare -A mydirs=(
  [bashlib]="$HOME/lib/bash"
  [defunct]="$HOME/src/_defunct"
  [dev]="$dir_scripts/dev"
  [stow]="$HOME/opt/stow"
  [inbox]="$dir_dropbox/inbox"
  [local]="$HOME/.local"
  [scratch]="$HOME/tmp/_scratch"
  [vsmm]="$dir_dropbox/www/vsmm"
)

g2()
{
  local name="$1"
  local place

  if [[ $name == */* ]]; then
    local child="${name#*/}"
    name="${name%%/*}"
  fi

  case $name in
    desktop)
      case $PLATFORM in
        windows)  place=$(cygpath --desktop) ;;
        mac)      place=~/Desktop ;;
      esac
      ;;

    docs)
      if [[ $HOSTNAME == Erato* ]]; then
        place=~/Dropbox/Documents
      elif [[ $PLATFORM == windows ]]; then
        place=$(cygpath --mydocs)
      else
        place=~/Documents
      fi
      ;;

    music)
      if [[ $PLATFORM == mac ]]; then
        place="$HOME/Music/iTunes/iTunes Media/Music"
      fi
      ;;

    drive)
      if place=$(find_drive "$myDrive" 2>/dev/null); then
        # also set environment variable
        export dir_drive=$place
      fi
      ;;
  esac

  if [[ -z $place ]]; then
    # remove illegal characters or ${!checkvar} expansion below will fail
    local checkvar="dir_${name//[^[:alnum:]_]}"

    if [[ -n ${!checkvar} ]]; then
      place="${!checkvar}"
    elif [[ -v mydirs[$name] ]]; then
      place="${mydirs[$name]}"
    elif [[ -d $HOME/$name${child:+/$child} ]]; then
      place="$HOME/$name"
    elif [[ -n $DIRSTACK ]]; then
      local d; for d in "${DIRSTACK[@]}"; do
        if [[ ${d##*/} == $name ]]; then
          place="${d/#~/$HOME}"
          break
        fi
      done
    fi
  fi

  place="${place}${child:+/$child}"

  if [[ -d $place ]]; then
    cd "$place"
    return 0
  elif [[ -n $place ]]; then
    scold "$FUNCNAME: $place: not found"
  else
    scold "$FUNCNAME: $1: not found"
  fi

  return 1
}
