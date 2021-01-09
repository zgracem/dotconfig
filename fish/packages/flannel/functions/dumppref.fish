function dumppref -d "export defaults to \$domain.yaml"
    test -n "$argv[1]"; or return 2

    set -l pref_dir ~/Dropbox/Projects/flannel/defaults

    for domain in $argv
        set -l yaml_file $pref_dir/$domain.yaml
        if test -f $yaml_file
            echo >&2 "file exists! $yaml_file"
            continue
        end
        prefexport $domain >$yaml_file
    end
end
