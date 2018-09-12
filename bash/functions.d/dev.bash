dev()
{
  local os=${OSTYPE%%+([^[:alpha:]])}

  local ruby_dir="$HOME/Dropbox/src/ruby"
  local www_dir="$HOME/Dropbox/www"
  local proj_dir=""

  # shellcheck disable=SC2221,SC2222
  case $1 in
    # vsmm)
    #   proj_dir=$dir_dropbox/www/vsmm
    #   _z_dev_subl_project ".sublime/vsmm"
    #   ;;
    vs2017|vs9)
      proj_dir=$dir_dropbox/www/vs2017
      _z_dev_subl_project "etc/vs2017"
      ;;

    ruby)
      proj_dir=$ruby_dir
      _z_dev_subl_project "ruby"
      ;;
    schemer)
      proj_dir=$ruby_dir/schemer
      _z_dev_subl_project "schemer"
      ;;
    weather)
      proj_dir=$ruby_dir
      _z_dev_subl_project "weather"
      ;;

    micro)
      proj_dir=$HOME/www/2016/microprocessor
      _z_dev_subl "$proj_dir"
      ;;

    cp437|gonehome)
      proj_dir=$www_dir/cp437
      _z_dev_subl "$proj_dir"
      ;;&
    gonehome)
      _z_dev_subl "$proj_dir/source/css/gonehome.sass"
      ;;

    *)
      # parse out case statements for usage string
      scold "Sorry, I don't know '$1'. Try:"

      mapfile -t opts \
        < <(declare -f "${FUNCNAME[0]}" \
            | sed -nE 's/.*[[:space:]]([[:alnum:]|]+)\)$/\1/p' \
            | sort \
            | uniq)

      scold "  ${opts[*]}"

      return 64
      ;;
  esac

  [[ -n $proj_dir ]] && cd "$proj_dir" || return
}

_z_dev_subl()
{
  [[ -n $SSH_CONNECTION ]] && return
  subl --add "$@"
}

_z_dev_subl_project()
{
  [[ -n $SSH_CONNECTION ]] && return
  subl --project "${proj_dir}/${1}.${OSTYPE%%+([^[:alpha:]])}.sublime-project"
}

# _z_dev_middleman()
# {
#   [[ $HOSTNAME == Athena* ]] || return

#   local proj_dir="$1"; shift

#   [[ $PWD == $proj_dir ]] || cd "$proj_dir"

#   if [[ -z $SSH_CONNECTION ]]; then
#     bundle exec middleman &
#   fi
# }
