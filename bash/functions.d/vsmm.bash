vsmm()
{
    local project_dir="$dir_dropbox/www/vsmm"

    cd "$project_dir"

    case $HOSTNAME in
        Athena)
            [[ -z $SSH_CONNECTION ]] && subl --project "$project_dir/misc/vsmm-osx.sublime-project"
            ;;
        *.atco.com)
            cygstart "$project_dir/misc/vsmm.sublime-project"
            ;;
        *)
            return 1
            ;;
    esac

    return 0
}
