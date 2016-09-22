dev()
{
  local os=${OSTYPE%%+([^[:alpha:]])}

  case $1 in
    ruby)
      subl --project "$HOME/Dropbox/etc/rubydev.${os}.sublime-project"
      ;;
    weather)
      local lib=~/Dropbox/src/gems/weather_ca
      cd "$lib"
      _dev_subl "$lib"
      ;;
    micro)
      local proj_dir=~/Dropbox/www/microprocessor
      _dev_subl "$proj_dir"
      _dev_middleman "$proj_dir"
      ;;
    gonehome)
      local proj_dir=~/Dropbox/www/cp437
      _dev_subl "$proj_dir" \
                "$proj_dir/source/gonehome.html.md" \
                "$proj_dir/source/css/gonehome.sass"
      _dev_middleman "$proj_dir"
      ;;
    cp437)
      local proj_dir=~/Dropbox/www/cp437
      _dev_subl "$proj_dir"
      _dev_middleman "$proj_dir"
      ;;
    *)
      local opts=($(declare -f $FUNCNAME \
                    | sed -nE 's/.*[[:space:]]([[:alnum:]]+)\)$/\1/p'))

      scold "Sorry, I don't know “$1”. Try:"
      scold "  ${opts[*]}"
      
      return $EX_DATAERR
      ;;
  esac
}

_dev_middleman()
{
  [[ $HOSTNAME == Athena* ]] || return $EX_NOHOST

  local proj_dir="$1"; shift
  
  if [[ $PWD != $proj_dir ]]; then
    cd "$proj_dir"
  fi

  if [[ -z $SSH_CONNECTION ]]; then
    bundle exec middleman &
  fi
}

_dev_subl()
{
  if [[ -n $SSH_CONNECTION ]]; then
    return
  else
    subl --add "$@"
  fi
}
