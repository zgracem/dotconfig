function dumppref -d "export defaults to \$domain.yaml"
    test -n "$argv[1]"; or return 2

    for domain in $argv
        set -l yaml_file $FLANNEL_DRAWER/$domain.yaml
        if test -f $yaml_file
            printf >&2 "file exists! %s\n" $yaml_file
            continue
        end
        prefexport $domain >$yaml_file
    end
end
