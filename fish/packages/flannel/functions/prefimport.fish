function prefimport -d "import defaults to \$domain from YAML"
    argparse --min-args 1 n/dryrun -- $argv; or return

    set -l test_domain org.inescapable.flannel.test

    set -l exit
    set exit[1] "no files found for "(set_color brred --italics)"%s"
    set exit[2] 1

    set -l short_domain $argv[1]

    for domain in $argv
        set short_domain $domain
        for file in $FLANNEL_DRAWER{,/private}/$domain.yaml
            test -f "$file"; or break

            set short_domain (string replace --regex "\A$FLANNEL_DRAWER/(.+)\.yaml\Z" '$1' $file)

            if set -q _flag_dryrun
                set domain $test_domain
            end

            if pyjamas -o plist $file | defaults import $domain -
                set exit OK 0

                set_color brgreen; echo -n $short_domain
                if set -q _flag_dryrun
                    set_color normal
                    set_color --italics; echo -n " ($test_domain)"
                end

                set_color normal; echo # newline
            else
                set exit "failed: %s" $status
                break
            end
        end
        test $exit[2] -eq 0; or break
    end

    if test $exit[2] -eq 0
        set -q _flag_dryrun; and defaults delete $test_domain 2>/dev/null
    else
        set_color red; printf >&2 "$exit[1]\n" $short_domain
        set_color normal
    end


    return $exit[2]
end
