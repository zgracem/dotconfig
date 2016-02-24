cp437()
{
    local project_dir="$dir_dropbox/www/cp437"

    cd "$project_dir"

    [[ $PWD == $project_dir ]] || return

    [[ -z $SSH_CONNECTION ]] && s "$project_dir"

    return 0
}
