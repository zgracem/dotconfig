# Requires bash 4+ (associative arrays)
(( BASH_VERSINFO[0] >= 4 )) || return

declare -A mydirs=(
  [icloud]="$HOME/Library/Mobile Documents/com~apple~CloudDocs"
  [bashlib]="$HOME/lib/bash"
  [defunct]="$HOME/Dropbox/src.old"
  [dev]="$HOME/scripts/dev"
  [stow]="$HOME/opt/stow"
  [inbox]="$HOME/Dropbox/inbox"
  [local]="$HOME/.local"
  [scratch]="$HOME/tmp/_scratch"
  [vs9]="$HOME/Dropbox/VS/www/vsdotcom"
  [history]="$HOME/.local/history"
  [imprint]="$HOME/Dropbox/VS/www/vsbooks"
  [ta]="$HOME/Dropbox/VS/www/2adotcom"
  [proj]="$HOME/Dropbox/Projects"
)

g2()
{ #: - go to a directory or directory alias
  #: $ g2 <dir|alias>
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
    elif [[ -n ${DIRSTACK[0]} ]]; then
      local d; for d in "${DIRSTACK[@]}"; do
        if [[ ${d##*/} == "$name" ]]; then
          place="${d/#~/$HOME}"
          break
        fi
      done
    fi
  fi

  place="${place}${child:+/$child}"

  if [[ -d $place ]]; then
    cd "$place" || return
    return 0
  elif [[ -n $place ]]; then
    scold "${FUNCNAME[0]}: $place: not found"
  else
    scold "${FUNCNAME[0]}: $1: not found"
  fi

  return 1
}
