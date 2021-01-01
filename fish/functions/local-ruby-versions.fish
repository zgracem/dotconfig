function local_ruby_versions --description "List all .ruby-version files and their values"
    for req in fd rbenv
        if not in-path $req
            echo >&2 "fatal error: this command requires `$req`"
            return 127
        end
    end

    set --local dirs ~/Dropbox ~/www
    set --local rv_files (fd -tf -sHFa ".ruby-version" $dirs)
    set --local rb_versions (rbenv versions --bare)
    set --local sep /

    for rv_file in $rv_files
        set --local rb_version (cat $rv_file)
        set --local project_dir (dirname $rv_file | string replace "$HOME" "~")

        printf "%s%s%s\n" $rb_version $sep $project_dir
    end \
        | sort -u \
        | while read line
        set --local info (string split --max=1 $sep $line)
        set --local rb_version $info[1]
        set --local project_dir $info[2]

        if not contains $rb_version $rb_versions
            # highlight uninstalled versions
            set rb_version (set_color brred)$rb_version(set_color normal)
        end

        printf "[%s] %s\n" $rb_version $project_dir
    end
end
