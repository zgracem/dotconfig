function flannel
    argparse --ignore-unknown n/dry-run -- $argv; or return

    function _hi
        echo -ns (set_color brgreen) "$argv" (set_color normal) \n
    end

    switch $argv[1]
        case dump # each DOMAIN to file(s) in PWD
            __flannel_dump $_flag_dry_run $argv[2..-1]

        case import # each DOMAIN from FLANNEL_DRAWER
            __flannel_import $_flag_dry_run $argv[2..-1]

        case export # each DOMAIN to stdout
            __flannel_export $_flag_dry_run $argv[2..-1]

        case print # each FILE to stdout
            for file in $argv[2..-1]
                if test -f $file
                    if set -q _flag_dry_run
                        echo plutil -convert xml1 (_hi $file) -o -
                    else
                        plutil -convert xml1 $file -o - | pyjamas --mode plist:yaml
                        or return
                    end
                else
                    echo >&2 "file not found! $file"
                    set -q _flag_dry_run; or return 1
                end
            end

        case touch # each DOMAIN's file in FLANNEL_DRAWER
            set -l files $FLANNEL_DRAWER/$argv[2..-1].yaml

            if set -q _flag_dry_run
                printf "gtouch %s\n" (_hi $files)
            else
                gtouch $files
            end

    end
end
