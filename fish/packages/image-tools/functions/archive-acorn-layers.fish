function archive-acorn-layers
    argparse 'n/dry-run' -- $argv
    or return

    set -l inbox ~/Library/"Mobile Documents"/com~apple~CloudDocs/Images/_inbox
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
            set -l layer_file $inbox/$layer.JPG
            if path is -f $layer_file
                if set -lq _flag_dry_run
                    echo "~~~ Would archive:" $layer_file
                else
                    /bin/mv $layer_file $used_dir
                    and echo ">>> Archived:" (basename $layer_file)
                end
            else if path is -f $used_dir/$layer.JPG
                echo "*** Already archived:" (basename $layer_file)
            else
                echo >&2 "*** Layer file not found: $layer"
            end
        end
    end
end
