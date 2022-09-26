function __flannel_export -d 'exports defaults for domain(s) to YAML'
    argparse n/dry-run -- $argv; or return

    set -q argv[2]; or set argv[2] -globalDomain

    for domain in $argv
        if set -q _flag_dry_run
            echo -n "defaults export "
            set_color brgreen; echo -n $domain; set_color normal
            echo " -"
        else
            defaults export $domain - | pyjamas --mode plist:yaml
        end
    end
end
