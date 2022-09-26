function __flannel_dump
    argparse --min-args 1 n/dry-run -- $argv; or return

    set -l timestamp (gdate +%Y%m%d_%H%M%S)

    for domain in $argv
        set -l yaml_file $PWD/$domain@$timestamp.yaml

        if path is -f $yaml_file
            # add nanoseconds to timestamp
            set timestamp (gdate +%Y%m%d_%H%M%S.%N | string replace -r '0{1,3}$' '')
            set yaml_file $PWD/$domain@$timestamp.yaml
        end

        if set -q _flag_dry_run
            echo __flannel_export (_hi $domain) \
                ">"(set_color brcyan)$yaml_file(set_color normal)
        else
            __flannel_export $domain >$yaml_file
            or return
        end
    end
end
