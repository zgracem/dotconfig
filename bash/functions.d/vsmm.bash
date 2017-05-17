vsmm()
{
  scold '*** Deprecated. Use `dev vsmm` instead.'
  dev vsmm
  # local project_dir="$dir_dropbox/www/vsmm"

  # if [[ $PWD != $project_dir ]]; then
  #   cd "$project_dir"
  # fi

  # case $HOSTNAME in
  #   Athena*)
  #     [[ -z $SSH_CONNECTION ]] && subl --project "$project_dir/.sublime/vsmm.darwin.sublime-project"
  #     ;;
  #   WS*)
  #     cygstart "$project_dir/.sublime/vsmm.sublime-project"
  #     ;;
  # esac

  # return 0
}
