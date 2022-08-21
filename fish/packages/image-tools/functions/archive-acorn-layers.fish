function archive-acorn-layers
    argparse 'n/dry-run' -- $argv
    or return

    set -l inboxes ~/Library/"Mobile Documents"/com~apple~CloudDocs/Images/_inbox
    set -a inboxes /Volumes/Hub/Art/inbox.old
    set -l used_art_dir /Volumes/Hub/Art/used

    set -l stock_dirs $HOME/{Downloads,Pictures}/unsplash
    set -l used_stock_dir /Volumes/Hub/Art/used/unsplash

    function list-acorn-layers
        $XDG_CONFIG_HOME/bin/acorn-layers.applescript $argv \
            | string match -rg '(IMG[_ ]\d{4}|[\w-]+-[a-zA-Z0-9_-]+-unsplash)'
    end

    for file in $argv
        set -l layers (list-acorn-layers $file)

        if test -z "$layers"
            echo >&2 "*** No archivable layers:" (basename $file)
            continue
        end

        for layer in $layers
            switch $layer
                case "IMG*"
                    set -f used_dir $used_art_dir
                    set -f layer_files $inboxes/$layer.JPG
                case "*-unsplash"
                    set -f used_dir $used_stock_dir
                    set -l layer_dirs $stock_dirs/**/
                    set -f layer_files (path normalize $layer_dirs/$layer.jpg)
                case "*"
                    continue
            end

            set -f --erase found
            for layer_file in $layer_files
                if set -fq found[1]
                    continue
                else if path is -f $layer_file
                    if set -lq _flag_dry_run
                        echo "~~~ Would archive:" $layer_file
                    else
                        /bin/mv $layer_file $used_dir
                        and echo ">>> Archived:" (basename $layer_file)
                    end
                    set -f found $layer_file
                else if path is -f $used_dir/$layer.jpg
                    echo "*** Already archived:" (basename $layer_file)
                    set -f found $used_dir/$layer.jpg
                else
                    echo >&2 "*** File not found:" $layer.jpg
                end
            end

            if not set -fq found[1]
                echo >&2 "*** File not found for layer: $layer"
            end
        end
    end
end
