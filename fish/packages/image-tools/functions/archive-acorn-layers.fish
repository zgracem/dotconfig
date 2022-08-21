function archive-acorn-layers
    argparse 'n/dry-run' -- $argv
    or return

    set -l inboxes ~/Library/"Mobile Documents"/com~apple~CloudDocs/Images/_inbox
    set -a inboxes /Volumes/Hub/Art/inbox.old
    set -l used_dir /Volumes/Hub/Art/used

    function list-acorn-layers
        $XDG_CONFIG_HOME/bin/acorn-layers.applescript $argv
    end

    for file in $argv
        set -l layers (list-acorn-layers $file | ag -o 'IMG[_ ]\d{4}')

        if test -z "$layers"
            echo >&2 "*** No `IMG_####` layers:" (basename $file)
            continue
        end

        for layer in $layers
            set -l layer_files $inboxes/$layer.JPG
            set -f --erase found
            for layer_file in $layer_files
                if path is -f $layer_file
                    if set -lq _flag_dry_run
                        echo "~~~ Would archive:" $layer_file
                    else
                        /bin/mv $layer_file $used_dir
                        and echo ">>> Archived:" (basename $layer_file)
                    end
                    set -f found $layer_file
                else if path is -f $used_dir/$layer.JPG
                    echo "*** Already archived:" (basename $layer_file)
                end
            end

            if not set -fq found[1]
                echo >&2 "*** File not found for layer: $layer"
            end
        end
    end
end
