function ls-rbenv --description "List all .ruby-version files and their values"
    for req in fd rbenv
        if not command -q $req
            echo >&2 "fatal error: this command requires `$req`"
            return 127
        end
    end

    set --local dirs ~/Developer/{libexec,ruby} ~/Dropbox ~/VS/www ~/www
    set --local rv_files (fd -tf -sHFa ".ruby-version" $dirs)
    set --local rb_versions (rbenv versions --bare)

    read --local global_version <$RBENV_ROOT/version

    for rv_file in $rv_files
        read --local rb_version <$rv_file
        set --local project_dir (dirname $rv_file | string replace "$HOME" "~")

        printf "%s/%s\n" $rb_version $project_dir
    end \
        | path sort -u \
        | while read line
        set --local info (string split --max=1 / $line)
        set --local rb_version $info[1]
        set --local project_dir $info[2]

        if not contains $rb_version $rb_versions
            # de-emphasize uninstalled versions
            set rb_version (set_color --dim)"\e[9m"$rb_version"\e[29m"(set_color normal)
        else if string match -q $rb_version $global_version
            # emphasize default version
            set rb_version (set_color --bold white)$rb_version(set_color normal)
        end

        echo -e "[$rb_version] $project_dir"
    end
end
