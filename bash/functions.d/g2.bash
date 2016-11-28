declare -A mydirs

mydirs[defunct]="$HOME/src/_defunct"
mydirs[dev]="$dir_scripts/dev"
mydirs[stow]="$HOME/opt/stow"
mydirs[inbox]="$dir_dropbox/inbox"
mydirs[scratch]="$HOME/tmp/_scratch"
mydirs[vsmm]="$dir_dropbox/www/vsmm"

g2()
{

  local name="$1" place

  if [[ $name == */* ]]; then
    local child="${name#*/}"
    name="${name%%/*}"
  fi

  # remove illegal characters or ${!checkvar} expansion below will fail
  local checkvar="dir_${name//[^[:alnum:]_]}"

  # first, see if we're trying to call a variable directly
  if [[ -n ${!checkvar} ]]; then
    place="${!checkvar}${child:+/$child}"
  elif [[ -v mydirs[$name] ]]; then
    place="${mydirs[$name]}"
  # maybe it's a directory in $HOME?
  elif [[ -d $HOME/$name${child:+/$child} ]]; then
    place="$HOME/$name${child:+/$child}"
  elif [[ -n $DIRSTACK ]]; then
    local re="$name"'$'
    local d; for d in "${DIRSTACK[@]}"; do
      if [[ $d =~ $re ]]; then
        place="${d/#~/$HOME}${child:+/$child}"
      fi
    done
  fi

  # any luck?
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
